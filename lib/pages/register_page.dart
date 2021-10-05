import 'dart:convert';
import 'dart:io';

import 'package:chat/config/palette.dart';
import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_date.dart';
import 'package:chat/widgets/default_img.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final apellidoCtrl = TextEditingController();
  final numerotelCtrl = TextEditingController();
  final birthCtrl = TextEditingController();
  //final roleCtrl = TextEditingController();
  final cargoCtrl = TextEditingController();
  final areaCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _globalkey = GlobalKey<FormState>();
  AuthService networkHandler = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height + 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Logo(titulo: 'Registro'),
                  titulo(context),
                  imgProfile(context),
                  form(context),
                  Labels(
                    ruta: 'login',
                    titulo: '¿Quieres ingresar con el usuario recien creado?',
                    subTitulo: '¡Ingresa ahora!',
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget titulo(BuildContext context) {
    return Title(
        color: Palette.colorBlue,
        child: Text("Registro",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                fontStyle: FontStyle.normal,
                letterSpacing: -1.2,
                color: Colors.blue[900])));
  }

  Widget imgProfile(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 70.0,
            backgroundImage: _imageFile == null
                ? AssetImage('assets/user-logo.png')
                : FileImage(File(_imageFile.path)),
          ),
          Positioned(
              bottom: 40.0,
              right: 11.0,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                  );
                },
                child: Icon(
                  Icons.photo_camera_rounded,
                  color: Colors.white,
                  size: 34.0,
                ),
              )),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Escoger foto de perfil",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.photo_camera_rounded),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Tomar fotografía"),
              ),
              TextButton.icon(
                icon: Icon(Icons.add_photo_alternate_outlined),
                onPressed: () {
                  importimg(ImageSource.gallery);
                },
                label: Text("Adjuntar de galería"),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.camera,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void importimg(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget form(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
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
          // CustomInput(
          //   icon: Icons.android_sharp,
          //   placeholder: 'Rol en la aplicación',
          //   keyboardType: TextInputType.text,
          //   textController: roleCtrl,
          // ),
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
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
            text: 'Crear cuenta',
            onPressed: authService.autenticando
                ? null
                : () async {
                    Map<String, String> addUserModel = {
                      'username': usernameCtrl.text.trim(),
                      'nombre': nameCtrl.text.trim(),
                      'apellido': apellidoCtrl.text.trim(),
                      'numerotel': numerotelCtrl.text.trim(),
                      'birth': birthCtrl.text.trim(),
                      //'role': role,
                      'cargo': cargoCtrl.text.trim(),
                      'area': areaCtrl.text.trim(),
                      'email': emailCtrl.text.trim(),
                      'password': passCtrl.text.trim(),
                    };
                    print(usernameCtrl);
                    print(nameCtrl);
                    print(apellidoCtrl);
                    print(numerotelCtrl);
                    print(birthCtrl);
                    //print(roleCtrl);
                    print(cargoCtrl);
                    print(areaCtrl);
                    print(emailCtrl);
                    print(passCtrl);
                    final registroOk =
                        await authService.post1('/login/new', addUserModel);
                    print(registroOk.body);
                    if (registroOk.statusCode == 200 ||
                        registroOk.statusCode == 201) {
                      socketService.connect();
                      final id = json.decode(registroOk.body)["data"];
                      var imageResponse = await authService.patchImage2(
                          '/login/update/$id', _imageFile.path);
                      print(imageResponse.statusCode);
                      if (imageResponse.statusCode == 200 ||
                          imageResponse.statusCode == 201) {
                        mostrarAlerta(context, 'Bienvenido',
                            'Usuario ingresado exitosamente');
                      }
                      usernameCtrl.clear();
                      nameCtrl.clear();
                      apellidoCtrl.clear();
                      numerotelCtrl.clear();
                      birthCtrl.clear();
                      //roleCtrl.clear();
                      cargoCtrl.clear();
                      areaCtrl.clear();
                      emailCtrl.clear();
                      passCtrl.clear();
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
