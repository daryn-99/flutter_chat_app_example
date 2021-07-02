import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/widgets/default_img.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfiletwoPage extends StatefulWidget {
  @override
  _ProfiletwoPageState createState() => _ProfiletwoPageState();
}

class _ProfiletwoPageState extends State<ProfiletwoPage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    final usuario = authService.usuario;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(usuario),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _posterTitulo(context, usuario),
            SizedBox(height: 10.0),
            _botonAdd(),
          ]),
        )
      ],
    ));
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
              'https://th.bing.com/th/id/OIP.CdcNDPToJO5MvCgwPmtLxwHaFj?pid=ImgDet&w=1600&h=1200&rs=1'),
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
