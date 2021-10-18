import 'package:chat/config/palette.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/profile.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/select_contact_page.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/services/usuarios_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}
//TODO: Cambiar la foto de perfil en el chat

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarioService = new UsuariosService();
  AuthService networkHandler = AuthService();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Profile profile;

  List<Usuario> usuarios = [];

  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
    //fetchDataProfile();
  }

  // void fetchDataProfile() async {
  //   final resp = await networkHandler.get('/profile/get');

  //   setState(() {
  //     profile = Profile.fromJson(resp['data']);
  //     //circular = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final usuario = authService.usuario;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.scaffold,
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => SelectContact()))
        },
        child: Icon(Icons.chat),
      ),
      appBar: AppBar(
        title: Text(
          usuario.nombre,
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left_sharp, color: Colors.black87),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'nav_screen');
          },
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online)
                ? Icon(Icons.check_circle, color: Palette.colorBlue)
                : Icon(Icons.offline_bolt, color: Colors.red),
          )
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
      leading: CircleAvatar(
        //backgroundImage: AuthService().getImage(profile.imgUrl),
        child: Text(usuario.nombre.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        //child: Text('8:16'),
        // CODIGO PARA MOSTRAR EL USUARIO EN LINEA
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.lightGreen : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => ChatPage()));
        });
        //Navigator.popAndPushNamed(context, 'chat');
      },
    );
  }

  _cargarUsuarios() async {
    this.usuarios = await usuarioService.getUsuarios();

    setState(() {});
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
