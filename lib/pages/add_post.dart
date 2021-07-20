import 'dart:convert';
import 'package:chat/config/palette.dart';
import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/post_service.dart';
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
  final _globalkey = GlobalKey<FormState>();

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController bodyCtrl = TextEditingController();

  ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  IconData iconphoto = Icons.attach_file;

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
              Navigator.pop(context);
            }),
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
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
            bodyTextField(),
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
            return "Title can't be empty";
          } else if (value.length > 100) {
            return "Title length should be <=100";
          }
          return null;
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
          prefixIcon: IconButton(
            icon: Icon(
              iconphoto,
              color: Palette.colorBlue,
            ),
            onPressed: takeCoverPhoto,
          ),
        ),
        maxLength: 100,
        maxLines: null,
      ),
    );
  }

  Widget bodyTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: bodyCtrl,
        keyboardType: TextInputType.text,
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
          labelText: "¿Qué esta pasando en RECO?",
        ),
        maxLines: null,
      ),
    );
  }

  Widget addButton(PostService postService) {
    return InkWell(
      onTap: () async {
        print(titleCtrl);
        print(bodyCtrl);
        final profileOk = await postService.poster(
            titleCtrl.text.trim(), bodyCtrl.text.trim());
        if (profileOk == true) {
          await mostrarAlerta(context, 'Actualización correcta', '');
          Navigator.popAndPushNamed(context, 'nav_screen');
        } else {
          mostrarAlerta(context, 'Actualización incorrecta', 'Rellenar campo');
        }
      },
      child: Center(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Palette.colorBlue),
          child: Center(
              child: Text(
            "Postear",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  void takeCoverPhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = coverPhoto;
      iconphoto = Icons.check_box;
    });
  }
}
