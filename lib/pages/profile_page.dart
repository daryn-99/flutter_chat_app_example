import 'package:flutter/material.dart';
import 'package:chat/widgets/default_img.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.all(10.0),
                  height: 200,
                  color: Colors.grey,
                  child: Image(
                    image: AssetImage('assets/back.jpg'),
                  )),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  color: Colors.grey,
                  child: Center(
                      child: Container(
                    alignment: Alignment(0.0, -1.8),
                    color: Colors.deepOrange,
                    height: 200,
                    width: 500,
                    child: Text(
                      "Nombre de usuario",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  )),
                ),
              )
            ],
          ),
          // Profile image
          Positioned(
            top: 150.0, // (background container size) - (circle height / 2)
            child: Column(
              children: <Widget>[
                DefaultImg(titulo: 'Perfil'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
