import 'package:chat/config/palette.dart';
import 'package:chat/models/ipost_models.dart';
import 'package:chat/models/profile.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/pages/profiletwo_page.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostTab extends StatefulWidget {
  @override
  _PostTabState createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  bool circular = true;
  AuthService networkHandler = AuthService();
  Post post;
  Usuario user;
  Profile profile;

  Widget profilePhoto = Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(50),
    ),
  );

  @override
  void initState() {
    fetchDataProfile();
    fetchData();
    super.initState();

    //fetchRole();
  }

  void fetchData() async {
    final resp = await networkHandler.get('/post/get');

    setState(() {
      post = Post.fromJson(resp['data']);
      circular = false;
    });
  }

  void fetchDataProfile() async {
    final resp = await networkHandler.get('/profile/get');

    setState(() {
      profile = Profile.fromJson(resp['data']);
      //dato = superModelProfile.dato;
      circular = false;
      profilePhoto = CircleAvatar(
          radius: 50, backgroundImage: AuthService().getImage(profile.imgUrl));
    });
  }

  void fetchDataUser() async {
    final resp = await networkHandler.get('/usuarios');

    setState(() {
      user = Usuario.fromJson(resp['usuarios']);
      circular = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: circular
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  brightness: Brightness.dark,
                  backgroundColor: Colors.white,
                  title: Text(
                    'RECONNET',
                    style: const TextStyle(
                        color: Palette.colorBlue,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1.2),
                  ),
                  centerTitle: false,
                  floating: true,
                ),
                SliverList(
                    delegate:
                        SliverChildListDelegate([postTap(context, user, post)]))
              ],
            ),
    );
  }

  Widget postTap(BuildContext context, Usuario usuario, Post post) {
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
                  postHeader(context, user, profile),
                  const SizedBox(height: 40.0),
                  Text(post.title),
                  post.coverImage != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            post.coverImage != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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

  Widget postHeader(BuildContext context, Usuario usuario, Profile profile) {
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
                usuario.nombre,
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

  Widget postStats(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Palette.colorYellow,
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
                color: Palette.colorYellow,
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
