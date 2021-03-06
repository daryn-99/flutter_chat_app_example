import 'package:chat/services/auth_services.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:provider/provider.dart';
import 'package:chat/helpers/motrar_alerta.dart';

import 'login_page.dart';

class ForgotPasswordPage extends StatelessWidget {
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
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final passCtrl1 = TextEditingController();

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
              icontwo: null),
          // CustomInput(
          //   icon: Icons.lock_outline,
          //   placeholder: 'Contrase??a',
          //   textController: passCtrl,
          //   isPassword: true,
          // ),
          // CustomInput(
          //   icon: Icons.lock_outline,
          //   placeholder: 'Repetir contrase??a',
          //   textController: passCtrl1,
          //   isPassword: true,
          // ),
          BotonAzul(
              text: 'Enviar',
              onPressed: () async {
                Map<String, String> data = {"email": emailCtrl.text};
                var response =
                    await authService.post('/usuarios/forgotPassword', data);
                print(response.body);
                print(response.statusCode);
                if (response.statusCode == 200) {
                  mostrarAlerta(context, 'Verificaci??n correcta',
                      'Revise el buz??n de su correo electr??nico ');
                  Navigator.restorablePushReplacementNamed(context, 'login');
                }
                // else {
                //   mostrarAlerta(context, 'Verificaci??n incorrecta',
                //       'Verificar credenciales');
                // }
                if (response.statusCode == 404) {
                  mostrarAlerta(
                      context, "Campo vacio", "El email no fue encontrado");
                }
                if (response.statusCode == 204) {
                  mostrarAlerta(
                      context, "Campo vacio", "El email es requerido");
                }
                if (response.statusCode == 206) {
                  mostrarAlerta(
                      context, "Campo vacio", "El email es requerido");
                }
              }
              // async {
              //   Map<String, String> data = {"password": passCtrl1.text};
              //   if (passCtrl == passCtrl1) {
              //     print("/usuarios/passwordUpdate/${emailCtrl.text}");
              //     var response = await authService.patch1(
              //         "/usuarios/passwordUpdate/${emailCtrl.text}", data);
              //     if (response.statusCode == 200 || response.statusCode == 201) {
              //       print("/user/update/${emailCtrl.text}");
              //       Navigator.pushAndRemoveUntil(
              //           context,
              //           MaterialPageRoute(builder: (context) => LoginPage()),
              //           (route) => false);
              //     }
              //   } else {
              //     mostrarAlerta(context, "Las contrase??as no coinciden",
              //         "Repitalo de nuevo");
              //   }
              // },
              ),
          SizedBox(height: 10.0),
          BotonAzul(
              text: "Cancelar",
              onPressed: () {
                Navigator.restorablePushReplacementNamed(context, 'login');
              })
        ],
      ),
    );
  }
}
