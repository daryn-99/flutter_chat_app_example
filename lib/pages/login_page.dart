import 'package:chat/config/palette.dart';
import 'package:chat/pages/forgot_Password.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:provider/provider.dart';
import 'package:chat/helpers/motrar_alerta.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(titulo: ''),
                  _Form(),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_outline,
            labelT: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
            icontwo: null,
          ),
          txtForm(context),
          BotonAzul(
            text: 'Ingrese',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());

                    if (loginOk) {
                      socketService.connect();
                      Navigator.restorablePushReplacementNamed(
                          context, 'nav_screen');
                    } else {
                      mostrarAlerta(context, 'Login incorrecto',
                          'Verificar credenciales');
                    }
                  },
          ),
          SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage()));
                },
                child: Text(
                  '¿Olvidó su contraseña?',
                  style: TextStyle(
                      color: Palette.colorBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
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
                Icons.lock_outline,
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
