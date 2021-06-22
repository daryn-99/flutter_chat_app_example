import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isActive;

  const ProfileAvatar({
    Key key,
    @required this.imageUrl,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Usuario usuario = new Usuario();
    return CircleAvatar(
      radius: 20.0,
      backgroundColor: Colors.grey[200],
      //child: Text(usuario.nombre.substring(0, 2)),
      backgroundImage: CachedNetworkImageProvider(imageUrl),
    );
  }
}
