import 'package:chat/config/palette.dart';
import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/profile.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/pages/home_page.dart';
import 'package:chat/pages/profiletwo_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/select_contact_page.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:chat/widgets/circle_buttom.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllUsers extends StatefulWidget {
  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  final usuarioService = new UsuariosService();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Usuario> usuarios = [];

  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de usuarios',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left_sharp, color: Colors.black87),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'menu_page');
          },
        ),
        actions: [
          CircleButton(
              icon: Icons.search,
              iconSize: 30.0,
              onPressed: () => print('Buscar'))
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Palette.colorBlue,
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario
          .apellido), //TODO:aqui debo de mostrar el ultimo mensaje enviado
      leading: PopupMenuButton<String>(
        padding: EdgeInsets.all(0),
        onSelected: (value) {
          if (value == "Ver") {
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => HomePage()));
          }
          if (value == 'Editar') {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => ProfiletwoPage()));
          }
          if (value == 'Eliminar') {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => RegisterPage()));
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: Text('Ver Usuario'),
              value: 'Ver',
            ),
            PopupMenuItem(
              child: Text('Editar Usuario'),
              value: 'Editar',
            ),
            PopupMenuItem(
              child: Text('Eliminar Usuario'),
              value: 'Eliminar',
            ),
          ];
        },
      ),
      //IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
      // CircleAvatar(
      //   child: Text(usuario.nombre.substring(0, 2)),
      //   backgroundColor: Colors.blue[100],
      // ),
      // onTap: () {
      //   final chatService = Provider.of<ChatService>(context, listen: false);
      //   chatService.usuarioPara = usuario;
      //   Navigator.popAndPushNamed(context, 'chat');
      // },
    );
  }

  _cargarUsuarios() async {
    this.usuarios = await usuarioService.getUsuarios();

    setState(() {});
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}