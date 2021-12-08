import 'dart:io';

import 'package:chat/config/palette.dart';
import 'package:chat/global/environments.dart';
import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/models/profile.dart';
import 'package:chat/models/register_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/pages/profile_editing.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/profile_get.dart';
import 'package:chat/services/profile_service.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfiletwoPage extends StatefulWidget {
  @override
  _ProfiletwoPageState createState() => _ProfiletwoPageState();
}

class _ProfiletwoPageState extends State<ProfiletwoPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuarioService = new UsuariosService();
  bool circular = true;
  AuthService networkHandler = AuthService();
  ProfilegetService getService = ProfilegetService();
  Profile profile;
  List<Usuario> usuario;
  final user = new Usuario();

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    //this._cargarUsuarios();
    //fetchData();
  }

  final profilegetService = new ProfilegetService();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
        body: circular
            ? CustomScrollView(
                slivers: <Widget>[
                  _crearAppbar(usuario),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 10.0),
                      _posterTitulo(context, usuario),
                      SizedBox(height: 10.0),
                      _botonAdd(context, user),
                      SizedBox(height: 40.0),
                      showProfile(context, usuario),
                      //_mostrarPerfil(),
                      //_cargarProfiles()
                    ]),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()));
  }

  Widget page = CircularProgressIndicator();

  Widget showProfile(BuildContext context, Usuario usuario) {
    return Center(
      child: Container(
        child: Text(usuario.descripcion),
      ),
    );
  }

  Widget _crearAppbar(Usuario usuario) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Palette.colorBlue,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: FadeInImage(
          image: AssetImage('assets/weather-in-Reco-1-1024x575.jpeg'),
          width: 130,
          height: 190,
          placeholder: AssetImage('assets/tenor.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Usuario usuario) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          profileImg(context, usuario),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(usuario.nombre + " " + usuario.apellido,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis),
                Text(usuario.cargo,
                    style: Theme.of(context).textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis),
                Text(usuario.area,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis),
                Text(usuario.birth,
                    style: Theme.of(context).textTheme.subtitle2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _botonAdd(BuildContext context, Usuario usuario) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        margin: EdgeInsets.only(left: 100),
        width: 70,
        height: 30,
        child: ElevatedButton(
            child: Text("Editar perfil",
                style: TextStyle(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              primary: Palette.colorBlue,
              shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => ProfileEditingPage()));
              });
              //Navigator.pushReplacementNamed(context, 'editing_profile');
            }));
  }

  Widget profileImg(BuildContext context, Usuario usuario) {
    return Center(
      child: networkHandler == null
          ? Text('-')
          : Stack(
              children: <Widget>[
                CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AuthService().getImage(usuario.imgUrl))
              ],
            ),
    );
  }

  _cargarUsuarios() async {
    this.usuario = await usuarioService.getUsuarios();

    setState(() {});
    await Future.delayed(Duration(milliseconds: 1000));
  }
}
