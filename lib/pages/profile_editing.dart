import 'dart:io';

import 'package:chat/config/palette.dart';
import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/pages/home_page.dart';
import 'package:chat/pages/profiletwo_page.dart';
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
  AuthService networkHandler = AuthService();
  bool circular = false;

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
            imgProfile(context),
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
          child: circular
              ? CircularProgressIndicator()
              : IconButton(
                  icon: Icon(Icons.check, color: Colors.black),
                  onPressed: () async {
                    setState(() {
                      circular = true;
                    });
                    Map<String, String> data = {'about': aboutCtrl.text};
                    print(aboutCtrl);
                    var response =
                        await networkHandler.post('/profile/add', data);
                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      if (_imageFile.path != null) {
                        var imageResponse = await networkHandler.patchImage(
                            '/profile/add/profileimg', _imageFile.path);
                        if (imageResponse.statusCode == 200) {
                          setState(() {
                            circular = false;
                          });
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => ProfiletwoPage()),
                              (route) => false);
                        }
                      } else {
                        setState(() {
                          circular = false;
                        });
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => ProfiletwoPage()),
                            (route) => false);
                        //Navigator.popAndPushNamed(context, 'profiletwo');
                      }
                    }
                  }),
        )
      ],
    );
  }

  Widget imgProfile(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 50.0,
            backgroundImage: _imageFile == null
                ? AssetImage('assets/user-logo.png')
                : FileImage(File(_imageFile.path)),
          ),
          Positioned(
              bottom: 20.0,
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
                  size: 28.0,
                ),
              )),
        ],
      ),
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
