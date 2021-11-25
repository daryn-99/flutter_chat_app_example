import 'dart:io';

import 'package:chat/config/palette.dart';
import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/pages/home_page.dart';
import 'package:chat/pages/nav_screen.dart';
import 'package:chat/pages/photo_profile.dart';
import 'package:chat/pages/profiletwo_page.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/profile_service.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:chat/widgets/default_img.dart';
import 'package:chat/widgets/input_two.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileEditingPage extends StatefulWidget {
  // final Usuario usuario;
  // ProfileEditingPage(this.usuario);
  @override
  _ProfileEditingPageState createState() => _ProfileEditingPageState();
}

class _ProfileEditingPageState extends State<ProfileEditingPage> {
  final usuarioService = new UsuariosService();
  TextEditingController descripcionCtrl = TextEditingController();
  // TextEditingController nombreCtrl = TextEditingController();
  // TextEditingController cargoCtrl = TextEditingController();
  // TextEditingController areaCtrl = TextEditingController();
  // TextEditingController birthCtrl = TextEditingController();

  List<Usuario> usuarios = [];

  AuthService networkHandler = AuthService();
  bool circular = false;

  // @override
  // void initState() {
  //   _cargarUsuarios();
  //   Usuario u = widget.usuario;
  //   descripcionCtrl = TextEditingController(text: u.descripcion);
  //   nombreCtrl = TextEditingController(text: u.nombre);
  //   cargoCtrl = TextEditingController(text: u.cargo);
  //   areaCtrl = TextEditingController(text: u.area);
  //   birthCtrl = TextEditingController(text: u.birth);

  //   super.initState();
  // }

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _globalkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    final usuario = authService.usuario;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _getAppBar(),
            SizedBox(height: 40.0),
            imgProfile(context, usuario),
            _cambiarFoto(),
            SizedBox(height: 40.0),
            InputTwo(
                placeholder: 'Ingresa tu descripcion',
                textController: descripcionCtrl),
            // InputTwo(
            //     placeholder: 'Ingresa tu nombre', textController: nombreCtrl),
            // InputTwo(
            //     placeholder: 'Ingresa tu cargo', textController: cargoCtrl),
            // InputTwo(placeholder: 'Ingresa tu area', textController: areaCtrl),
            // InputTwo(
            //     placeholder: 'Ingresa tu año de nacimiento',
            //     textController: birthCtrl)
          ]),
        )
      ],
    ));
  }

  Widget _getAppBar() {
    final profileService = ProfileService();
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 70.0,
      title: Text(
        'Editar perfil',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      elevation: 1,
      leading: IconButton(
          onPressed: () => {
                Navigator.popAndPushNamed(context, 'nav_screen'),
              },
          icon: Icon(Icons.not_interested_rounded, color: Colors.black),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10),
          child: circular
              ? CircularProgressIndicator()
              : IconButton(
                  icon: Icon(Icons.check, color: Colors.black),
                  onPressed: () async {
                    setState(() {
                      circular = true;
                    });
                    Map<String, String> data = {
                      'descripcion': descripcionCtrl.text.trim(),
                      // 'nombre': nombreCtrl.text.trim(),
                      // 'cargo': cargoCtrl.text.trim(),
                      // 'area': areaCtrl.text.trim(),
                      // 'birth': birthCtrl.text.trim(),
                    };
                    print(descripcionCtrl);
                    // print(nombreCtrl);
                    // print(cargoCtrl);
                    // print(areaCtrl);
                    // print(birthCtrl);
                    var response = await networkHandler.patchDesc(
                        '/usuarios/updateDes', data);
                    print(response.statusCode);
                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      setState(() {
                        circular = false;
                      });
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => NavScreen()));
                    } else {
                      setState(() {
                        circular = false;
                      });
                    }
                  }),
        )
      ],
    );
  }

  Widget imgProfile(BuildContext context, Usuario usuario) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 50.0,
            backgroundImage: _imageFile == null
                ? AuthService().getImage(usuario.imgUrl)
                //AssetImage('assets/user-logo.png')
                : FileImage(File(_imageFile.path)),
          ),
          // Positioned(
          //     bottom: 20.0,
          //     right: 11.0,
          //     child: InkWell(
          //       onTap: () {
          //         showModalBottomSheet(
          //           context: context,
          //           builder: ((builder) => bottomSheet()),
          //         );
          //       },
          //       child: Icon(
          //         Icons.photo_camera_rounded,
          //         color: Colors.white,
          //         size: 28.0,
          //       ),
          //     )),
        ],
      ),
    );
  }

  Widget _cambiarFoto() {
    return TextButton(
        onPressed: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => PhotoProfile()));
          });
        },
        child: Text(
          'Cambiar foto de perfil',
          style: TextStyle(color: Colors.black),
        ));
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

  _cargarUsuarios() async {
    this.usuarios = await usuarioService.getAllUsuarios();

    setState(() {});
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
  }
}
