import 'package:chat/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class CreatePostContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                ProfileAvatar(
                  imageUrl: 'http://www.dant.dk/doge/img/app_icon.png',
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: '¿Qué esta pasando?',
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
                  FlatButton.icon(
                    onPressed: () => print('Comunicados'),
                    icon: const Icon(
                      Icons.insert_drive_file_sharp,
                      color: Colors.yellow,
                    ),
                    label: Text('Comunicados'),
                  ),
                  const VerticalDivider(width: 8.0),
                  FlatButton.icon(
                    onPressed: () => print('Foto'),
                    icon: const Icon(Icons.add_photo_alternate_rounded,
                        color: Colors.green),
                    label: Text('Foto'),
                  ),
                  const VerticalDivider(width: 8.0),
                  FlatButton.icon(
                    onPressed: () => print('Videos'),
                    icon: const Icon(
                      Icons.video_collection,
                      color: Colors.orange,
                    ),
                    label: Text('Video'),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
