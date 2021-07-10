import 'package:chat/config/palette.dart';
import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/profile_service.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/widgets/default_img.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileEditingPage extends StatefulWidget {
  @override
  _ProfileEditingPageState createState() => _ProfileEditingPageState();
}

class _ProfileEditingPageState extends State<ProfileEditingPage> {
  TextEditingController aboutCtrl = TextEditingController();

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
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
            SizedBox(height: 10.0),
            DefaultImg(titulo: 'Profile'),
            SizedBox(height: 40.0),
            _crearAbout(),
            SizedBox(height: 40.0),
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
          child: IconButton(
              icon: Icon(Icons.check, color: Colors.black),
              onPressed: () async {
                print(aboutCtrl);
                final profileOk =
                    await profileService.profiler(aboutCtrl.text.trim());
                if (profileOk == true) {
                  await Navigator.popAndPushNamed(context, 'profiletwo');
                } else {
                  mostrarAlerta(
                      context, 'Actualización incorrecta', 'Rellenar campo');
                }
              }),
        )
      ],
    );
  }

  Widget _crearAbout() {
    return TextField(
      controller: aboutCtrl,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Escribe tu descripción'),
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
}
