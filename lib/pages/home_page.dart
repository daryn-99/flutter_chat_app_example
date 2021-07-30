import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/config/palette.dart';
import 'package:chat/data/data.dart';
import 'package:chat/models/ipost_models.dart';
import 'package:chat/models/profile.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/pages/profiletwo_page.dart';
import 'package:chat/pages/select_contact_page.dart';
import 'package:chat/pages/terminos_condiciones.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/post_get.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:chat/widgets/circle_buttom.dart';
import 'package:chat/widgets/create_post_container.dart';
import 'package:chat/widgets/post_container.dart';
import 'package:chat/widgets/profile_avatar.dart';
import 'package:chat/widgets/responsive.dart';
import 'package:chat/widgets/rooms.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  Profile profile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
    fetchDataProfile();
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
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      //drawerScrimColor: Colors.transparent,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                child: Column(children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AuthService().getImage(profile.imgUrl),
              ),
              SizedBox(
                height: 10,
              ),
              Text(usuario.username),
            ])),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text('Ver perfil'),
              trailing: Icon(MdiIcons.accountCircleOutline),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => ProfiletwoPage()));
              },
            ),
            ListTile(
              title: Text('Ver Terminos y condiciones de uso'),
              trailing: Icon(Icons.library_books),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => TerminosPage()));
              },
            ),
            ListTile(
                title: Text('Cerrar sesión'),
                trailing: Icon(MdiIcons.logout),
                onTap: () {
                  socketService.disconnect();
                  Navigator.pushReplacementNamed(context, 'login');
                  AuthService.deleteToken();
                })
          ],
        ),
      ),
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
                    "RECONET",
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
                // SliverToBoxAdapter(
                //     //child: CreatePostContainer(),
                //     ),
                // //Container con los cumpleañeros
                // SliverPadding(
                //   padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                //   sliver: SliverToBoxAdapter(
                //     child: Rooms(),
                //   ),
                // ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    postContainer(context, usuario, post),
                    postContainer(context, usuario, post),
                    postContainer(context, usuario, post),
                    postContainer(context, usuario, post),
                    postContainer(context, usuario, post),
                    postContainer(context, usuario, post),
                    postContainer(context, usuario, post),
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
                  postHeader(context, usuario),
                  const SizedBox(height: 40.0),
                  Text(post.title),
                  Text(post.coverImage),
                  post.coverImage != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            post.coverImage != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    // child: Image.network(
                    //     'https://www.recoroatan.com/wp-content/uploads/2021/07/WhatsApp-Image-2021-06-06-at-12.40.31.jpeg')
                    //NetworkImage('http://192.168.80.124:3000/api/storage/1627483691175-profile.jpg'),
                    child: Image(image: AuthService().getImage(post.coverImage))
                    //child: CachedNetworkImage(imageUrl: post.coverImage),
                    // child: Image.network(post.coverImage,
                    //     loadingBuilder: (context, child, progress) {
                    //   return progress == null
                    //       ? child
                    //       : LinearProgressIndicator(color: Colors.blue);
                    // }),
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
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => ProfiletwoPage()));
          },
          child: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.grey[200],
              backgroundImage: AuthService().getImage(profile.imgUrl)
              // NetworkImage(
              //     'http://192.168.80.124:3000/api/storage/1627484367691-profiledos.jpeg'),
              ),
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
