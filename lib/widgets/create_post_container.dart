import 'package:chat/services/auth_services.dart';
import 'package:chat/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CreatePostContainer extends StatefulWidget {
  @override
  _CreatePostContainerState createState() => _CreatePostContainerState();
}

class _CreatePostContainerState extends State<CreatePostContainer> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

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
                      'https://scontent.fsap1-1.fna.fbcdn.net/v/t1.6435-9/189418878_3817325464982636_394025055086716610_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=973b4a&_nc_ohc=10n0tHGIHHwAX8WGdWe&_nc_ht=scontent.fsap1-1.fna&oh=11d4d3b42412b7c2f0364cba04357566&oe=60E2C629',
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
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
                    onPressed: () => print('Adjuntos'),
                    icon: const Icon(
                      MdiIcons.fileDocument,
                      color: Colors.orange,
                    ),
                    label: Text('Adjuntos',
                        style: TextStyle(color: Colors.black54)),
                  ),
                  const VerticalDivider(width: 8.0),
                  TextButton.icon(
                    onPressed: () => print('Foto'),
                    icon: const Icon(Icons.add_photo_alternate_rounded,
                        color: Colors.green),
                    label: Text(
                      'Foto',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
