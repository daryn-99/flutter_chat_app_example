import 'package:chat/models/profile.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/pages/profiletwo_page.dart';
import 'package:chat/services/auth_services.dart';
import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({Key key, @required this.profile}) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => ProfiletwoPage()));
            });
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (builder) => ProfiletwoPage()));
          },
          child: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.grey[200],
              backgroundImage: AuthService().getImage(profile.imgUrl)),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.about,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Row(
              //   children: [
              //     // Text(
              //     //   '${post} • ',
              //     //   style: TextStyle(
              //     //     color: Colors.grey[600],
              //     //     fontSize: 12.0,
              //     //   ),
              //     // ),
              //     Icon(
              //       Icons.public,
              //       color: Colors.grey[600],
              //       size: 12.0,
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
