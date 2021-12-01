import 'package:chat/models/usuario.dart';
import 'package:chat/pages/add_post.dart';
import 'package:chat/pages/all_users_page.dart';
import 'package:chat/pages/charts.dart';
import 'package:chat/pages/forgot_Password.dart';
import 'package:chat/pages/home_page.dart';
import 'package:chat/pages/menu_page.dart';
import 'package:chat/pages/modify_page.dart';
import 'package:chat/pages/nav_screen.dart';
import 'package:chat/pages/new_password.dart';
import 'package:chat/pages/photo_profile.dart';
import 'package:chat/pages/profile_editing.dart';
import 'package:chat/pages/profiletwo_page.dart';
import 'package:chat/pages/select_contact_page.dart';
import 'package:chat/pages/terminos_condiciones.dart';
import 'package:chat/widgets/post_tap.dart';
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
  'profiletwo': (_) => ProfiletwoPage(),
  //'editing_profile': (_) => ProfileEditingPage(),
  'add_post': (_) => AddBlog(),
  'menu_page': (_) => MenuPage(),
  'all_users': (_) => AllUsers(),
  'terminos': (_) => TerminosPage(),
  'charts': (_) => ChartPage(),
  'forgot_password': (_) => ForgotPasswordPage(),
  'post_tab': (_) => PostTab(),
  'photo_profile': (_) => PhotoProfile(),
  'new_password': (_) => NewPasswordPage()
};
