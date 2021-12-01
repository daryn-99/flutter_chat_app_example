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
    return Scaffold(
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
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final passCtrl = TextEditingController();
  final passCtrl1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.lock_outline,
            labelT: 'Nueva contraseña',
            textController: passCtrl,
            isPassword: true,
            icontwo: null,
          ),
          CustomInput(
            icon: Icons.vpn_key_outlined,
            labelT: 'Repetir contraseña',
            textController: passCtrl1,
            isPassword: true,
            icontwo: null,
          ),
          BotonAzul(
            text: 'Enviar',
            onPressed: () async {
              //   Map<String, String> data = {"email": emailCtrl.text};
              //   var response =
              //       await authService.post('/usuarios/forgotPassword', data);
              //   print(response.body);
              //   if (response.statusCode == 200) {
              //     Navigator.restorablePushReplacementNamed(context, 'login');
              //   } else {
              //     mostrarAlerta(context, 'Verificación incorrecta',
              //         'Verificar credenciales');
              //   }
              //   if (response.statusCode == 204) {
              //     mostrarAlerta(
              //         context, "Campo vacio", "El email es requerido");
              //   }
              //   if (response.statusCode == 206) {
              //     mostrarAlerta(
              //         context, "Campo vacio", "El email es requerido");
              //   }
              // }
              // async {
              Map<String, String> data = {"password": passCtrl.text.trim()};
              if (passCtrl.text == passCtrl1.text) {
                print("/usuarios/newpasswordUpdate");
                var response = await authService.patch1(
                    "/usuarios/newpasswordUpdate", data);
                print(response.statusCode);
                if (response.statusCode == 200 || response.statusCode == 201) {
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
                Navigator.restorablePushReplacementNamed(context, 'login');
              })
        ],
      ),
    );
  }
}
