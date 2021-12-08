import 'dart:convert';
import 'package:chat/config/palette.dart';
import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/pages/nav_screen.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/post_service.dart';
import 'package:chat/widgets/overlay_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class AddBlog extends StatefulWidget {
  AddBlog({Key key}) : super(key: key);

  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  bool isActive = true;
  final _globalkey = GlobalKey<FormState>();
  AuthService networkHandler = AuthService();

  TextEditingController titleCtrl = TextEditingController();

  bool circular = false;
  ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  IconData iconphoto = Icons.attach_file;
  IconData iconsss = Icons.photo_camera;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final postService = PostService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'nav_screen');
              //Navigator.pop(context);
            }),
        actions: <Widget>[
          TextButton(
            //TODO: Poner un await
            onPressed: () {
              try {
                if (_imageFile.path != null &&
                    _globalkey.currentState.validate()) {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => OverlayCard(
                        imagefile: _imageFile, title: titleCtrl.text)),
                  );
                } else {
                  mostrarAlerta(context, 'Para tener una previsualización',
                      'Primero adjunte una imagen');
                }
              } catch (e) {
                return mostrarAlerta(context, 'Para tener una previsualización',
                    'Primero adjunte una imagen');
              }
            },
            child: Text(
              "Preview",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          )
        ],
      ),
      body: Form(
        key: _globalkey,
        child: ListView(
          children: <Widget>[
            titleTextField(),
            SizedBox(
              height: 20,
            ),
            addButton(postService),
          ],
        ),
      ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: titleCtrl,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value.isEmpty) {
            return mostrarAlerta(
                context, 'El titulo no puede ir vacio', 'Rellenar campos');
          }
          return null;
          //mostrarAlerta(context, "Accion realizada con exito", "a");
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Palette.colorBlue,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Palette.scaffold,
                width: 2,
              ),
            ),
            labelText: "Agrega un archivo y una descripción",
            labelStyle: TextStyle(color: Colors.black, fontSize: 18),
            prefixIcon: IconButton(
              icon: Icon(
                iconphoto,
                color: Palette.colorBlue,
              ),
              onPressed: takeCoverPhoto,
            ),
            icon: IconButton(
              icon: Icon(
                iconsss,
                color: Palette.colorBlue,
              ),
              onPressed: takePhoto,
            )),
        maxLines: null,
      ),
    );
  }

  Widget addButton(PostService postService) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      margin: EdgeInsets.only(),
      width: 70,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Palette.colorBlue,
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          child: Text("Postear"),
          onPressed: isActive
              ? () async {
                  setState(() => isActive = false);
                  // if (titleCtrl != "") {
                  //   mostrarAlerta(context, "No puede ir vacio", "Papo");
                  // }
                  try {
                    if (_imageFile.path != null &&
                        _globalkey.currentState.validate()) {
                      Map<String, String> addBlogModel = {
                        'title': titleCtrl.text
                      };
                      print(titleCtrl);
                      //Post addBlogModel = Post(title: titleCtrl.text);

                      var response =
                          await networkHandler.post1('/post/new', addBlogModel);
                      print(response.body);
                      print(response.statusCode);
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        mostrarAlerta(
                            context, 'Post realizado', 'Exito al postear');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavScreen()),
                            (route) => false);
                      }

                      if (response.statusCode == 403) {
                        mostrarAlerta(context, 'Permiso denegado',
                            'Requiere permisos de Gerente o Administrador');
                      }
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        final id = json.decode(response.body)["data"];
                        //if (_imageFile.path != null) {
                        var imageResponse = await networkHandler.patchImage(
                            '/post/updateImg/$id', _imageFile.path);
                        print(imageResponse.statusCode);
                        if (imageResponse.statusCode == 404) {
                          mostrarAlerta(
                              context, 'Imagen vacia', 'Adjunte una imagen');
                        }
                        if (imageResponse.statusCode == 403) {
                          mostrarAlerta(context, 'Permiso denegado',
                              'Requiere permisos de Gerente o Administrador');
                        }
                        if (imageResponse.statusCode == 203) {
                          mostrarAlerta(context, 'Post incompleto',
                              'Error al cargar la imagen');
                        }

                        //}
                      }
                    }
                  } catch (e) {
                    return mostrarAlerta(context, 'Ups!',
                        'Debes de adjuntar una imagen para hacer un post');
                  }
                  // Center(
                  //   child: Container(
                  //     height: 50,
                  //     width: 200,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: Palette.colorBlue),
                  //     child: Center(
                  //         child: Text(
                  //       "Postear",
                  //       style: TextStyle(
                  //           color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  //     )),
                  //   ),
                  // ),
                }
              : null),
    );
  }

  void takeCoverPhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = coverPhoto;
      iconphoto = Icons.check_box;
    });
  }

  void takePhoto() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.camera,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
