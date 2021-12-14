import 'package:chat/services/auth_services.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:provider/provider.dart';
import 'package:chat/helpers/motrar_alerta.dart';

import 'login_page.dart';

class NewPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  children: <Widget>[
                    Logo(titulo: ''),
                    _Form(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final passCtrl = TextEditingController();
  final passCtrl1 = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: <Widget>[
            // CustomInput(
            //   icon: Icons.lock_outline,
            //   labelT: 'Nueva contraseña',
            //   textController: passCtrl,
            //   isPassword: true,
            //   icontwo: null,
            // ),
            txtForm(context),
            txtFormTwo(context),
            BotonAzul(
              text: 'Enviar',
              onPressed: () async {
                Map<String, String> data = {"password": passCtrl.text.trim()};
                if (passCtrl.text == passCtrl1.text) {
                  print("/usuarios/newpasswordUpdate");
                  var response = await authService.patch1(
                      "/usuarios/newpasswordUpdate", data);
                  print(response.statusCode);
                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    await mostrarAlerta(
                        context,
                        'Contraseña actualizada exitosamente',
                        ' Ingrese con su nueva contraseña');
                    print(response.statusCode);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  }
                } else {
                  mostrarAlerta(context, "Las contraseñas no coinciden",
                      "Repitalo de nuevo");
                }
              },
            ),
            SizedBox(height: 10.0),
            BotonAzul(
                text: "Cancelar",
                onPressed: () {
                  Navigator.popAndPushNamed(context, 'nav_screen');
                })
          ],
        ),
      ),
    );
  }

  Widget txtForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        cursorColor: Theme.of(context).backgroundColor,
        controller: passCtrl,
        autocorrect: false,
        obscureText: obscureText,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: GestureDetector(
              child: Icon(
                Icons.lock_outline_rounded,
              ),
            ),
            labelText: 'Nueva Contraseña',
            labelStyle: TextStyle(color: Colors.grey[700]),
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: obscureText
                    ? const Icon(Icons.visibility_off_outlined,
                        color: Colors.grey)
                    : const Icon(Icons.visibility_outlined,
                        color: Colors.grey)),
            focusedBorder: InputBorder.none,
            border: InputBorder.none),
      ),
    );
  }

  Widget txtFormTwo(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        cursorColor: Theme.of(context).backgroundColor,
        controller: passCtrl1,
        autocorrect: false,
        obscureText: obscureText,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: GestureDetector(
              child: Icon(
                Icons.vpn_key_outlined,
              ),
            ),
            labelText: 'Contraseña',
            labelStyle: TextStyle(color: Colors.grey[700]),
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: obscureText
                    ? const Icon(Icons.visibility_off_outlined,
                        color: Colors.grey)
                    : const Icon(Icons.visibility_outlined,
                        color: Colors.grey)),
            focusedBorder: InputBorder.none,
            border: InputBorder.none),
      ),
    );
  }
}
