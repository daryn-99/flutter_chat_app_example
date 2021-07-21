import 'package:chat/global/environments.dart';
import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/models/profile.dart';
import 'package:chat/models/register_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/profile_get.dart';
import 'package:chat/services/profile_service.dart';
import 'package:chat/widgets/default_img.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProfiletwoPage extends StatefulWidget {
  @override
  _ProfiletwoPageState createState() => _ProfiletwoPageState();
}

class _ProfiletwoPageState extends State<ProfiletwoPage> {
  bool circular = true;
  AuthService networkHandler = AuthService();
  ProfilegetService getService = ProfilegetService();
  Profile profile;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    final resp = await networkHandler.get('/profile/get');
    setState(() {
      profile = Profile.fromJson(resp['data']);
      circular = false;
    });

    // headers: {
    //   'Content-Type': 'application/json',
    //   'x-token': await AuthService.getToken()
    // });
  }

  final profilegetService = new ProfilegetService();

  Profile profilezzz;

  // @override
  // void initState() {
  //   this._cargarProfiles();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    // final profilegetService = Provider.of<ProfilegetService>(context);
    // final profile = profilegetService.profile;

    //print(profile);

    return Scaffold(
        body: circular
            ? Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: <Widget>[
                  _crearAppbar(usuario),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 10.0),
                      _posterTitulo(context, usuario),
                      SizedBox(height: 10.0),
                      _botonAdd(),
                      SizedBox(height: 40.0),
                      //showProfile(context, profile)
                      _mostrarPerfil(),
                      //_cargarProfiles()
                    ]),
                  )
                ],
              ));
  }

  _cargarProfiles() async {
    this.profile = await profilegetService.getProfiles();

    // setState(() {});
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
  }

  Widget page = CircularProgressIndicator();

  // void checkProfile() async {
  //   final resp = await http.get(
  //       Uri.parse('${Environment.apiUrl}/profile/checkprofiles'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'x-token': await AuthService.getToken()
  //       });

  //       if (resp.statusCode == 200) {
  //     final registerResponse = registerResponseFromJson(resp.body);
  //     this.usuario = registerResponse.usuario;

  //     return true;
  //   } else {
  //     final respBody = jsonDecode(resp.body);
  //     return respBody['msg'];
  //   }
  //   setState(() {
  //     page = showProfile();
  //   });
  // }

  Widget showProfile(BuildContext context, Profile profile) {
    return Center(
      child: Text(profile.about),
    );
  }

  Widget _crearAppbar(Usuario usuario) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        // title: Text(
        //   usuario.nombre,
        //   style: TextStyle(color: Colors.white, fontSize: 16.0),
        // ),
        background: FadeInImage(
          image: NetworkImage(
              'https://image.freepik.com/vector-gratis/fondo-construccion-graficos-informacion-construccion-diseno-portada-libro_40382-67.jpg'),
          width: 130,
          height: 190,
          placeholder: NetworkImage(
              'https://th.bing.com/th/id/OIP.8Wx1NF2j4eAMj9FpMoDohgHaFj?pid=ImgDet&rs=1'),
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
          DefaultImg(titulo: 'Profile'), //TODO: Quitar el icon de la camara
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(usuario.nombre,
                    style: Theme.of(context).textTheme.title,
                    overflow: TextOverflow.ellipsis),
                Text(usuario.cargo,
                    style: Theme.of(context).textTheme.title,
                    overflow: TextOverflow.ellipsis),
                Text(usuario.area,
                    style: Theme.of(context).textTheme.subhead,
                    overflow: TextOverflow.ellipsis),
                Text(usuario.birth,
                    style: Theme.of(context).textTheme.subhead,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _mostrarPerfil() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      // child: Row(
      //   children: <Widget>[
      //     DefaultImg(titulo: 'Profile'), //TODO: Quitar el icon de la camara
      //     SizedBox(width: 20.0),
      //     Flexible(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Text(profile.about,
      //               style: Theme.of(context).textTheme.title,
      //               overflow: TextOverflow.ellipsis),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
      child: Text(
        profile.about,
        //'Hola! A menudo me estarán viendo por los alrededores, soy practicante de la carrera de Ingeniería en informática',
        textAlign: TextAlign.justify,

        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget _botonAdd() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        margin: EdgeInsets.only(left: 100),
        width: 70,
        height: 30,
        child: ElevatedButton(
            child: Text("Editar descripción",
                style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'editing_profile');
            }));
  }
}
