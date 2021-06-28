import 'package:chat/data/data.dart';
import 'package:chat/pages/groups_page.dart';
import 'package:chat/pages/menu_page.dart';
import 'package:chat/pages/notification_page.dart';
import 'package:chat/pages/profiletwo_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:chat/widgets/custom_app_bar.dart';
import 'package:chat/widgets/custom_tab_bar.dart';
import 'package:chat/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'home_page.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomePage(),
    UsuariosPage(), //aqui iran las pantallas de la barra desplegable
    RegisterPage(),
    ProfiletwoPage(),
    NotificationPage(),
    MenuPage(),
  ];
  final List<IconData> _icons = const [
    Icons.home,
    MdiIcons.facebookMessenger, //videos cargados
    MdiIcons.accountGroupOutline, //grupos de trabajo
    MdiIcons.accountCircleOutline, //cuenta
    MdiIcons.bellOutline, //notificaciones
    Icons.menu,
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        appBar: Responsive.isDesktop(context)
            ? PreferredSize(
                preferredSize: Size(screenSize.width, 100.0),
                child: CustomAppBar(
                  currentUser: currentUser,
                  icons: _icons,
                  selectedIndex: _selectedIndex,
                  onTap: (index) => setState(() => _selectedIndex = index),
                ),
              )
            : null,
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: !Responsive.isDesktop(context)
            ? Container(
                padding: const EdgeInsets.only(top: 0.0),
                color: Colors.white,
                child: CustomTabBar(
                  icons: _icons,
                  selectedIndex: _selectedIndex,
                  onTap: (index) => setState(() => _selectedIndex = index),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
