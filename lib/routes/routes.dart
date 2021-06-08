import 'package:chat/pages/home_page.dart';
import 'package:chat/pages/nav_screen.dart';
import 'package:chat/pages/select_contact_page.dart';
import 'package:flutter/material.dart';

import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/usuarios_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
  'select_contact': (_) => SelectContact(),
  'home': (_) => HomePage(),
  'nav_screen': (_) => NavScreen(),
};
