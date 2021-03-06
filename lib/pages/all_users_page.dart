import 'package:chat/config/palette.dart';
import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/profile.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/pages/home_page.dart';
import 'package:chat/pages/menu_page.dart';
import 'package:chat/pages/modify_page.dart';
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
    _cargarUsuarios();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final usuarios = authService.usuario;

    return WillPopScope(
      onWillPop: () async {
        return false;
        // () async {
        //   print('Back Button pressed!');

        //   final shouldPop = await showWarning(context);
        //   return shouldPop;
      },
      child: Scaffold(
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
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => MenuPage()));
              });
              //Navigator.pushReplacementNamed(context, 'menu_page');
            },
          ),
          // actions: [
          //   CircleButton(
          //       icon: Icons.search,
          //       iconSize: 30.0,
          //       onPressed: () => print('Buscar'))
          // ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Palette.scaffold),
            waterDropColor: Palette.colorBlue,
          ),
          child: _listViewUsuarios(),
        ),
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
      title: Text(usuario.nombre + " " + usuario.apellido),
      subtitle: Text(usuario.email),
      onTap: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => ModifyPage(usuario)));
        });
      },
      onLongPress: () {
        removeUser(context, usuario);
      },
    );
  }

  removeUser(BuildContext context, Usuario usuario) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Eliminar Usuario"),
              content:
                  Text("Esta seguro de eliminar a " + usuario.nombre + "?"),
              actions: [
                TextButton(
                    onPressed: () {
                      usuarioService.deleteUser(usuario.uid).then((user) {
                        _refreshController.refreshCompleted();
                        mostrarAlerta(context, "Acci??n realizada con ??xito",
                            "Usuario eliminado");

                        //Navigator.pop(context);
                        //_refreshController.refreshCompleted();
                        // if (user.uid.isEmpty) {
                        //   setState(() {});
                        //   Navigator.pop(context);
                        // }
                      });

                      Navigator.pop(context);
                    },
                    child: Text(
                      "Eliminar",
                      style: TextStyle(color: Colors.red),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ));
  }

  _cargarUsuarios() async {
    this.usuarios = await usuarioService.getAllUsuarios();

    setState(() {});
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
