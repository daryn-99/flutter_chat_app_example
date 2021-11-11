import 'package:chat/config/palette.dart';
import 'package:chat/pages/all_users_page.dart';
import 'package:chat/pages/nav_screen.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/widgets/boton_azul.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Administración de usuarios',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              wordSpacing: -1.2,
              fontWeight: FontWeight.bold,
            )),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => NavScreen()),
                  (route) => false);
            });
            //Navigator.pushReplacementNamed(context, 'menu_page');
          },
          icon: Icon(Icons.chevron_left_sharp, color: Colors.black87),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 120),
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: <Widget>[
              boton1(context),
              // BotonAzul(
              //     text: 'Agregar usuarios',
              //     onPressed: () => {
              //           WidgetsBinding.instance.addPostFrameCallback((_) {
              //             Navigator.pushReplacement(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (_) => RegisterPage()));
              //           })
              //           // Navigator.push(
              //           //     context,
              //           //     MaterialPageRoute(
              //           //         builder: (builder) => RegisterPage()))
              //         }),
              SizedBox(
                width: 15.0,
                height: 20,
              ),
              boton(context)
              // BotonAzul(
              //     text: 'Todos los usuarios',
              //     onPressed: () => {
              //           Navigator.push(context,
              //               MaterialPageRoute(builder: (builder) => AllUsers()))
              //         }),
              // SizedBox(
              //   width: 15.0,
              //   height: 20,
              // ),
              // BotonAzul(
              //     text: 'Ultimos Agregados',
              //     onPressed: () => {print('Ultimos usuarios')}),
              // SizedBox(
              //   width: 15.0,
              //   height: 20,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget boton(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Palette.colorBlue,
      shape: StadiumBorder(),
      onPressed: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => AllUsers()))
      },
      child: Container(
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text('Todos los usuarios',
              style: TextStyle(color: Colors.white, fontSize: 17)),
        ),
      ),
    );
  }

  Widget boton1(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Palette.colorBlue,
      shape: StadiumBorder(),
      onPressed: () => {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => RegisterPage()));
        })
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (builder) => RegisterPage()))
      },
      child: Container(
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text('Agregar usuarios',
              style: TextStyle(color: Colors.white, fontSize: 17)),
        ),
      ),
    );
  }
}
