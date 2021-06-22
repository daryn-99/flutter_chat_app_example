import 'package:chat/config/palette.dart';
import 'package:chat/data/data.dart';
import 'package:chat/models/post_models.dart';
import 'package:chat/widgets/circle_buttom.dart';
import 'package:chat/widgets/create_post_container.dart';
import 'package:chat/widgets/post_container.dart';
import 'package:chat/widgets/rooms.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        //Parte de arriba
        slivers: [
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            title: Text(
              'RECOMMUNICATION',
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
                  icon: MdiIcons.inbox,
                  iconSize: 30.0,
                  onPressed: () => print('Ideas Inbox')),
              CircleButton(
                icon: MdiIcons.facebookMessenger,
                iconSize: 30.0,
                onPressed: () {
                  Navigator.popAndPushNamed(context, 'usuarios');
                },
              ),
            ],
          ),
          //Container para publicar
          SliverToBoxAdapter(
            child: CreatePostContainer(),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            sliver: SliverToBoxAdapter(
              child: Rooms(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final Post post = posts[index];
                return PostContainer(
                  post: post,
                );
              },
              childCount: posts.length,
            ),
          ),
        ],
      ),
    );
  }
}
