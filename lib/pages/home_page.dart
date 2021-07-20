import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/config/palette.dart';
import 'package:chat/data/data.dart';
import 'package:chat/models/ipost_models.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/pages/select_contact_page.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/post_get.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:chat/widgets/circle_buttom.dart';
import 'package:chat/widgets/create_post_container.dart';
import 'package:chat/widgets/post_container.dart';
import 'package:chat/widgets/profile_avatar.dart';
import 'package:chat/widgets/responsive.dart';
import 'package:chat/widgets/rooms.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'add_post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool circular = true;
  AuthService networkHandler = AuthService();
  PostgetService getPost = PostgetService();
  Post post;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  void fetchData() async {
    final resp = await networkHandler.get('/post/get');
    setState(() {
      post = Post.fromJson(resp['data']);
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        backgroundColor: Palette.colorBlue,
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => AddBlog()))
        },
        child: Icon(Icons.add),
      ),
      body: circular
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              //Parte de arriba
              slivers: <Widget>[
                SliverAppBar(
                  brightness: Brightness.light,
                  backgroundColor: Colors.white,
                  title: Text(
                    usuario.nombre,
                    style: const TextStyle(
                      color: Palette.colorBlue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.2,
                    ),
                  ),
                  centerTitle: false,
                  floating: true,
                  actions: [
                    CircleButton(
                      icon: Icons.search_rounded,
                      iconSize: 30.0,
                      onPressed: () => print('Buscar'),
                    ),
                    CircleButton(
                        icon: MdiIcons.bell,
                        iconSize: 30.0,
                        onPressed: () => print('Notifications')),
                  ],
                ),
                //Container para publicar
                SliverToBoxAdapter(
                    //child: CreatePostContainer(),
                    ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                  sliver: SliverToBoxAdapter(
                    child: Rooms(),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    // SizedBox(height: 10.0),
                    // postHeader(context, usuario),
                    // SizedBox(height: 10.0),
                    // postStats(context),
                    // SizedBox(height: 10.0),
                    postContainer(context, usuario, post)
                  ]),
                ),
              ],
            ),
    );
  }

  Widget postContainer(BuildContext context, Usuario usuario, Post post) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: isDesktop ? 5.0 : 0.0,
      ),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : 'No puede ser',
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
                  postHeader(context, usuario),
                  const SizedBox(height: 40.0),
                  Text(post.title),
                  post.coverImage != ''
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            post.coverImage != ''
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CachedNetworkImage(imageUrl: post.coverImage),
                  )
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

  Widget postHeader(BuildContext context, Usuario usuario) {
    return Row(
      children: [
        ProfileAvatar(
          imageUrl: '',
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
