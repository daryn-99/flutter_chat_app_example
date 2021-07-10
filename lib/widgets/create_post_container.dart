import 'package:chat/helpers/motrar_alerta.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/post_service.dart';
import 'package:chat/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CreatePostContainer extends StatefulWidget {
  @override
  _CreatePostContainerState createState() => _CreatePostContainerState();
}

class _CreatePostContainerState extends State<CreatePostContainer> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController titleCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final postService = PostService();

    final usuario = authService.usuario;

    return Container(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                ProfileAvatar(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTOkHm3_mPQ5PPRvGtU6Si7FJg8DVDtZ47rw&usqp=CAU',
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: titleCtrl,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration.collapsed(
                      hintText: '¿Qué esta pasando en Reco?',
                    ),
                  ),
                )
              ],
            ),
            const Divider(height: 10.0, thickness: 0.5),
            Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () => {importimg(ImageSource.gallery)},
                    icon: const Icon(
                      MdiIcons.fileDocument,
                      color: Colors.orange,
                    ),
                    label: Text('Adjuntos',
                        style: TextStyle(color: Colors.black54)),
                  ),
                  const VerticalDivider(width: 8.0),
                  TextButton.icon(
                    onPressed: () => {importimg(ImageSource.gallery)},
                    icon: const Icon(Icons.add_photo_alternate_rounded,
                        color: Colors.green),
                    label: Text(
                      'Foto',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  const VerticalDivider(width: 8.0),
                  TextButton.icon(
                    onPressed: () async {
                      print(titleCtrl);
                      final profileOk =
                          await postService.poster(titleCtrl.text.trim());
                      if (profileOk == true) {
                        await mostrarAlerta(
                            context, 'Actualización correcta', '');
                      } else {
                        mostrarAlerta(context, 'Actualización incorrecta',
                            'Rellenar campo');
                      }
                    },
                    icon: const Icon(Icons.check, color: Colors.black),
                    label: Text(
                      '',
                      style: TextStyle(color: Colors.black54),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
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
