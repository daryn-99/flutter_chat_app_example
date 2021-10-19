import 'package:chat/config/palette.dart';
import 'package:chat/models/ipost_models.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({
    Key key,
    @required this.post,
    // @required this.usuario,
    // @required this.profile
  }) : super(key: key);

  final Post post;
  // final Usuario usuario;
  // final Profile profile;

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: isDesktop ? 5.0 : 0.0,
      ),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //postHeader(context),
                  const SizedBox(height: 20.0),
                  Text(post.title),
                  post.coverImage != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            post.coverImage != null
                ?
                // InkWell(
                //     onTap: () {
                //       Future.delayed(Duration(seconds: 1), () {
                //         Navigator.of(context).pushAndRemoveUntil(
                //             MaterialPageRoute(builder: (context) => PostTab()),
                //             (route) => false);
                //       });
                //     },
                //     child:
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child:
                        Image(image: AuthService().getImage(post.coverImage)))
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: postStats(context),
            ),
          ],
        ),
      ),
    );
  }

  // Widget postHeader(BuildContext context) {
  //   return Row(
  //     children: [
  //       InkWell(
  //         onTap: () {
  //           WidgetsBinding.instance.addPostFrameCallback((_) {
  //             Navigator.pushReplacement(
  //                 context, MaterialPageRoute(builder: (_) => ProfiletwoPage()));
  //           });
  //           // Navigator.push(context,
  //           //     MaterialPageRoute(builder: (builder) => ProfiletwoPage()));
  //         },
  //         child: CircleAvatar(
  //             radius: 20.0,
  //             backgroundColor: Colors.grey[200],
  //             backgroundImage: AuthService().getImage(profile.imgUrl)),
  //       ),
  //       const SizedBox(width: 8.0),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               usuario.nombre,
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //             // Row(
  //             //   children: [
  //             //     Text(
  //             //       '${} • ',
  //             //       style: TextStyle(
  //             //         color: Colors.grey[600],
  //             //         fontSize: 12.0,
  //             //       ),
  //             //     ),
  //             //     Icon(
  //             //       Icons.public,
  //             //       color: Colors.grey[600],
  //             //       size: 12.0,
  //             //     )
  //             //   ],
  //             // ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget postStats(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Palette.colorBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lightbulb_outline_sharp,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4.0),
            // Expanded(
            //   child: Text(
            //     '${post.}',
            //     style: TextStyle(
            //       color: Colors.grey[600],
            //     ),
            //   ),
            // ),
            // Text(
            //   '${post.comments} Comments',
            //   style: TextStyle(
            //     color: Colors.grey[600],
            //   ),
            // ),
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
              icon: Icon(
                Icons.lightbulb_outline_sharp,
                color: Palette.colorBlue,
                size: 25.0,
              ),
              label: 'Charge',
              onTap: () => print('Watt'),
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.commentPlusOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'Comentar',
              onTap: () => print('Comment'),
            ),
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const _PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
