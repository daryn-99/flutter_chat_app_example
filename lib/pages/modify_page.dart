import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/pages/all_users_page.dart';
import 'package:chat/pages/menu_page.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:provider/provider.dart';

class ModifyPage extends StatefulWidget {
  final Usuario usuario;
  ModifyPage(this.usuario);
  @override
  _ModifyPageState createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  TextEditingController idCtrl;
  TextEditingController usernameCtrl;
  TextEditingController nameCtrl;
  TextEditingController apellidoCtrl;
  TextEditingController numerotelCtrl;
  TextEditingController birthCtrl;
  TextEditingController cargoCtrl;
  TextEditingController areaCtrl;
  TextEditingController emailCtrl;

  AuthService networkHandler = AuthService();

  @override
  void initState() {
    Usuario u = widget.usuario;
    idCtrl = TextEditingController(text: u.uid);
    usernameCtrl = TextEditingController(text: u.username);
    nameCtrl = TextEditingController(text: u.nombre);
    apellidoCtrl = TextEditingController(text: u.apellido);
    numerotelCtrl = TextEditingController(text: u.numerotel);
    birthCtrl = TextEditingController(text: u.birth);
    cargoCtrl = TextEditingController(text: u.cargo);
    areaCtrl = TextEditingController(text: u.area);
    emailCtrl = TextEditingController(text: u.email);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Modificar",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -1.2,
                  color: Colors.blue[900])),
          leading: IconButton(
            onPressed: () {
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MenuPage()),
                    (route) => false);
              });
              //Navigator.pushReplacementNamed(context, 'menu_page');
            },
            icon: Icon(Icons.chevron_left_sharp, color: Colors.black87),
          ),
        ),
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height + 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(titulo: ''),
                  form(context),
                ],
              ),
            ),
          ),
        ));
  }

  Widget form(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuarioService = new UsuariosService();
    Usuario usuario;

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.format_list_numbered_outlined,
            placeholder: 'Id de usuario',
            keyboardType: TextInputType.text,
            textController: idCtrl,
          ),
          CustomInput(
            icon: Icons.person_pin_rounded,
            placeholder: 'Nombre de usuario',
            keyboardType: TextInputType.text,
            textController: usernameCtrl,
          ),
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.account_circle,
            placeholder: 'Apellido',
            keyboardType: TextInputType.text,
            textController: apellidoCtrl,
          ),
          CustomInput(
            icon: Icons.phone,
            placeholder: 'Numero de celular',
            keyboardType: TextInputType.phone,
            textController: numerotelCtrl,
          ),
          CustomInput(
            icon: Icons.cake,
            placeholder: 'Fecha de nacimiento',
            keyboardType: TextInputType.text,
            textController: birthCtrl,
          ),
          CustomInput(
            icon: Icons.engineering,
            placeholder: 'Cargo en la empresa',
            keyboardType: TextInputType.text,
            textController: cargoCtrl,
          ),
          CustomInput(
            icon: Icons.place,
            placeholder: 'Area de su cargo',
            keyboardType: TextInputType.text,
            textController: areaCtrl,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          BotonAzul(
            text: 'Actualizar usuario',
            onPressed: () async {
              Map<String, String> addUserModel = {
                'username': usernameCtrl.text.trim(),
                'nombre': nameCtrl.text.trim(),
                'apellido': apellidoCtrl.text.trim(),
                'numerotel': numerotelCtrl.text.trim(),
                'birth': birthCtrl.text.trim(),
                'cargo': cargoCtrl.text.trim(),
                'area': areaCtrl.text.trim(),
                'email': emailCtrl.text.trim(),
              };
              print(usernameCtrl);
              print(nameCtrl);
              print(apellidoCtrl);
              print(numerotelCtrl);
              print(birthCtrl);
              print(cargoCtrl);
              print(areaCtrl);
              print(emailCtrl);
              final id = idCtrl;
              print(id);
              var registroOk = await authService.patch(
                  '/usuarios/updateUser/$id', addUserModel);
              print(registroOk.body);
              print(registroOk.statusCode);
              if (registroOk.statusCode == 200 ||
                  registroOk.statusCode == 201) {
                //socketService.connect();
                mostrarAlerta(
                    context, 'Exito', 'Usuario actualizado exitosamente');
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => AllUsers()));
              } else {
                mostrarAlerta(
                    context, 'Registro incorrecto', 'Rellenar campos');
              }
            },
          )
        ],
      ),
    );
  }
}
