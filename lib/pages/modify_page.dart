import 'dart:convert';
import 'dart:io';

import 'package:chat/config/palette.dart';
import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/pages/all_users_page.dart';
import 'package:chat/pages/menu_page.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:image_picker/image_picker.dart';
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
  FixedExtentScrollController scrollControllerArea;
  String id;
  AuthService networkHandler = AuthService();

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _globalkey = GlobalKey<FormState>();

  int indexes = 0;
  final area = [
    'CSA',
    'Planta Generación',
    'Taller',
    'Planta Distribución',
    'Trade Winds',
    'Planta Solar Sur',
    'Santa Helena'
  ];

  @override
  void initState() {
    Usuario u = widget.usuario;
    id = u.uid;
    usernameCtrl = TextEditingController(text: u.username);
    nameCtrl = TextEditingController(text: u.nombre);
    apellidoCtrl = TextEditingController(text: u.apellido);
    numerotelCtrl = TextEditingController(text: u.numerotel);
    birthCtrl = TextEditingController(text: u.birth);
    cargoCtrl = TextEditingController(text: u.cargo);
    areaCtrl = TextEditingController(text: u.area);
    emailCtrl = TextEditingController(text: u.email);

    areaCtrl = TextEditingController(text: area[indexes]);
    scrollControllerArea = FixedExtentScrollController(initialItem: indexes);

    super.initState();
  }

  @override
  void dispose() {
    areaCtrl.dispose();
    scrollControllerArea.dispose();
    super.dispose();
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
                    MaterialPageRoute(builder: (context) => AllUsers()),
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
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Logo(titulo: ''),
                  imgProfile(context),
                  form(context),
                ],
              ),
            ),
          ),
        ));
  }

  Widget imgProfile(BuildContext context) {
    return Center(
      heightFactor: 1.2,
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

  Widget txtAreaPicker(BuildContext context) {
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
          controller: areaCtrl,
          autocorrect: false,
          readOnly: true,
          enableInteractiveSelection: false,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: GestureDetector(
              child: Icon(
                Icons.place,
              ),
            ),
            border: InputBorder.none,
            labelText: 'Área de su cargo',
            labelStyle: TextStyle(color: Colors.grey[700]),
            suffixIcon: IconButton(
                onPressed: () {
                  scrollControllerArea.dispose();
                  scrollControllerArea =
                      FixedExtentScrollController(initialItem: indexes);
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                            actions: [buildAreaPicker()],
                            cancelButton: CupertinoActionSheetAction(
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Palette.colorBlue),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ));
                },
                icon: Icon(Icons.arrow_circle_down_sharp)),
          ),
        ));
  }

  Widget buildAreaPicker() => SizedBox(
        height: 150,
        child: StatefulBuilder(
          builder: (context, setState) => CupertinoPicker(
            diameterRatio: 1.30,
            scrollController: scrollControllerArea,
            looping: true,
            itemExtent: 44,
            selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              background: Palette.colorBlue.withOpacity(0.1),
            ),
            children: List.generate(area.length, (indexes) {
              final isSelected = this.indexes == indexes;
              final articulo = area[indexes];
              final color =
                  isSelected ? Palette.colorBlue : CupertinoColors.black;
              return Center(
                child: Text(
                  articulo,
                  style: TextStyle(color: color, fontSize: 20),
                ),
              );
            }),
            onSelectedItemChanged: (indexes) {
              setState(() => this.indexes = indexes);

              final articulo = area[indexes];
              areaCtrl.text = articulo;
              print('Selected Item: $articulo');
            },
          ),
        ),
      );

  Widget form(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuarioService = new UsuariosService();
    //Usuario usuario;

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.person_pin_rounded,
            keyboardType: TextInputType.text,
            textController: usernameCtrl,
            labelT: 'Nombre de usuario',
            icontwo: IconButton(
                onPressed: () {
                  mostrarAlerta(context, 'Ayuda',
                      'Utiliza la primer letra del nombre y el primer apellido');
                },
                icon: Icon(Icons.error_outline_sharp)),
          ),
          CustomInput(
              icon: Icons.perm_identity,
              labelT: 'Nombre',
              keyboardType: TextInputType.text,
              textController: nameCtrl,
              icontwo: null),
          CustomInput(
              icon: Icons.account_circle,
              labelT: 'Apellido',
              keyboardType: TextInputType.text,
              textController: apellidoCtrl,
              icontwo: null),
          CustomInput(
            icon: Icons.phone,
            labelT: 'Numero de celular',
            keyboardType: TextInputType.phone,
            textController: numerotelCtrl,
            icontwo: IconButton(
                onPressed: () {
                  mostrarAlerta(
                      context, 'Ayuda', 'No agregar guiones, solo números');
                },
                icon: Icon(Icons.error_outline_sharp)),
          ),
          CustomInput(
            icon: Icons.cake,
            labelT: 'Fecha de nacimiento',
            keyboardType: TextInputType.text,
            textController: birthCtrl,
            icontwo: IconButton(
                onPressed: () {
                  mostrarAlerta(
                      context, 'Ayuda', 'Utilizar el formato Año/Mes/Dia');
                },
                icon: Icon(Icons.error_outline_sharp)),
          ),
          CustomInput(
            icon: Icons.engineering,
            labelT: 'Cargo en la empresa',
            keyboardType: TextInputType.text,
            textController: cargoCtrl,
            icontwo: null,
          ),
          txtAreaPicker(context),
          // CustomInput(
          //   icon: Icons.place,
          //   labelT: 'Area de su cargo',
          //   keyboardType: TextInputType.text,
          //   textController: areaCtrl,
          //   icontwo: IconButton(
          //       onPressed: () {
          //         mostrarAlerta(context, 'Ayuda',
          //             'Ejemplos de areas de trabajo: CSA, Medición, Trade Winds, etc');
          //       },
          //       icon: Icon(Icons.error_outline_sharp)),
          // ),
          CustomInput(
              icon: Icons.mail_outline,
              labelT: 'Correo',
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl,
              icontwo: null),
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
              var registroOk = await authService.patch(
                  '/usuarios/updateUser/$id', addUserModel);
              print(registroOk.body);
              print(registroOk.statusCode);
              if (registroOk.statusCode == 200 ||
                  registroOk.statusCode == 201) {
                //socketService.connect();
                //final _id = json.decode(registroOk.body)["data"];
                mostrarAlerta(
                    context, 'Actualizado', 'Usuario actualizado exitosamente');
                print(registroOk.body);
                print(id);
                var imageResponse = await authService.patchImage2(
                    '/login/photoProfile/$id', _imageFile.path);
                print(_imageFile.path);
                print(imageResponse.statusCode);
                if (imageResponse.statusCode == 200 ||
                    imageResponse.statusCode == 201) {
                  mostrarAlerta(
                      context, 'Bienvenido', 'Usuario ingresado exitosamente');
                }
                //   await mostrarAlerta(
                //       context, 'Exito', 'Usuario actualizado exitosamente');
                //   Navigator.pushReplacement(
                //       context, MaterialPageRoute(builder: (_) => AllUsers()));
              } else {
                await mostrarAlerta(
                    context, 'Registro incorrecto', 'Rellenar campos');
              }
            },
          )
        ],
      ),
    );
  }
}
