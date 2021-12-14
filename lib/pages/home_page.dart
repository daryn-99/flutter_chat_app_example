import 'package:chat/config/palette.dart';
import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/models/ipost_models.dart';
import 'package:chat/models/profile.dart';
import 'package:chat/models/role_model.dart';
import 'package:chat/models/super_model.dart';
import 'package:chat/models/super_model_profile.dart';
import 'package:chat/models/super_model_role.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/pages/new_password.dart';
import 'package:chat/pages/profiletwo_page.dart';
import 'package:chat/pages/terminos_condiciones.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:chat/widgets/post_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'add_post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final roleService = new RoleService();
  final usuarioService = new UsuariosService();
  bool circular = true;
  AuthService networkHandler = AuthService();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Post> data = [];
  // List<Profile> profile = [];
  List<Role> info;
  Profile profile;
  List<Usuario> usuario;
  SuperModel superModel;
  SuperModelProfile superModelProfile;
  SuperModelRole superModelRole;

  Widget profilePhoto = Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(50),
    ),
  );

  @override
  void initState() {
    //fetchDataProfile();
    this._cargarUsuarios();
    fetchData();
    super.initState();

    //fetchRole();
  }

  void elState() {
    //fetchDataProfile();
  }

  void fetchData() async {
    final resp = await networkHandler.get('/post/getStoryOther');
    superModel = SuperModel.fromJson(resp);
    setState(() {
      data = superModel.data;
      circular = false;
    });

    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void fetchDataProfile() async {
    final resp = await networkHandler.get('/profile/get');
    //superModelProfile = SuperModelProfile.fromJson(resp);
    setState(() {
      profile = Profile.fromJson(resp['data']);
      //dato = superModelProfile.dato;
      circular = false;
      profilePhoto = CircleAvatar(
          radius: 50, backgroundImage: AuthService().getImage(profile.imgUrl));
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    final socketService = Provider.of<SocketService>(context);
    final roles = authService.roles;
    return Scaffold(
      //drawerScrimColor: Colors.transparent,

      drawer: WillPopScope(
        onWillPop: () async {
          return false;
          // () async {
          //   print('Back Button pressed!');

          //   final shouldPop = await showWarning(context);
          //   return shouldPop;
        },
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  child: Column(children: <Widget>[
                //profilePhoto,
                CircleAvatar(
                    radius: 50,
                    backgroundImage: AuthService().getImage(usuario
                        .imgUrl) //TODO:el error de inicio es provocado por está linea
                    ),
                SizedBox(
                  height: 10,
                ),
                Text(usuario.username),
              ])),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text('Ver perfil'),
                trailing: Icon(MdiIcons.accountCircleOutline),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ProfiletwoPage()));
                },
              ),
              ListTile(
                title: Text('Ver Terminos y condiciones de uso'),
                trailing: Icon(Icons.library_books),
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => TerminosPage()),
                        (route) => false);
                  });

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (builder) => TerminosPage()));
                },
              ),
              ListTile(
                title: Text('Cambiar contraseña'),
                trailing: Icon(Icons.password_rounded),
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => NewPasswordPage()),
                        (route) => false);
                  });

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (builder) => TerminosPage()));
                },
              ),
              ListTile(
                  title: Text('Cerrar sesión'),
                  trailing: Icon(MdiIcons.logout),
                  onTap: () {
                    socketService.disconnect();
                    Navigator.pushReplacementNamed(context, 'login');
                    AuthService.deleteToken();
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        backgroundColor: Palette.colorBlue,
        onPressed: () => {
          // if (roles.name == "administrador")
          //   {
          Navigator.restorablePushReplacementNamed(context, 'add_post')
        },
        child: Icon(Icons.add),
      ),
      body: circular
          ? Center(child: CircularProgressIndicator())
          : SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              onRefresh: fetchData,
              header: WaterDropHeader(
                complete: Icon(Icons.check, color: Palette.colorBlue),
                waterDropColor: Palette.colorBlue,
              ),
              child: CustomScrollView(
                //Parte de arriba
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    brightness: Brightness.light,
                    backgroundColor: Colors.white,
                    title: Text(
                      "RECONET",
                      style: const TextStyle(
                        color: Palette.colorBlue,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1.2,
                      ),
                    ),
                    iconTheme: IconThemeData(color: Palette.colorBlue),
                    centerTitle: false,
                    floating: true,
                    actions: [
                      IconButton(
                        icon: Image.asset('assets/icono.ico'),
                        iconSize: 40.0,
                        onPressed: () => null,
                      ),
                      //   CircleButton(
                      //       icon: MdiIcons.bell,
                      //       iconSize: 30.0,
                      //       onPressed: () => print('Notifications')),
                    ],
                  ),
                  //Container para publicar
                  // SliverToBoxAdapter(
                  //     //child: CreatePostContainer(),
                  //     ),
                  // //Container con los cumpleañeros
                  // SliverPadding(
                  //   padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                  //   sliver: SliverToBoxAdapter(
                  //     child: Rooms(),
                  //   ),
                  // ),
                  // SliverList(
                  //   delegate: SliverChildListDelegate(dato.length > 0
                  //       ? dato.map((items) => PostHeader(profile: items)).toList()
                  //       : mostrarAlerta(context, 'Ups!',
                  //           '"No hay publicaciones disponibles"')),
                  // ),
                  SliverList(
                    delegate: SliverChildListDelegate(data.length > 0
                        ? data
                            .map((item) => PostContainer(
                                  post: item,
                                ))
                            .toList()
                        : mostrarAlerta(context, 'Ups!',
                            '"No hay publicaciones disponibles"')),
                  ),
                ],
              ),
            ),
    );
  }

  _cargarUsuarios() async {
    usuario = await usuarioService.getUsuarios();

    setState(() {});
    await Future.delayed(Duration(milliseconds: 1000));
  }
}
