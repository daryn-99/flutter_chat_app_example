import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String titulo;

  const Logo({Key key, @required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 160,
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/Reco-Logo.png')),
            SizedBox(height: 20),
            Text(this.titulo,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 30))
          ],
        ),
      ),
    );
  }
}
