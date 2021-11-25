import 'dart:io';

import 'package:chat/models/getprofile_response.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/post_get.dart';
import 'package:chat/services/post_service.dart';
import 'package:chat/services/profile_get.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:flutter/material.dart';

import 'package:chat/routes/routes.dart';
import 'package:provider/provider.dart';

import 'services/profile_service.dart';

void main()
//=> runApp(MyApp());
{
  runApp(MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatService()),
        ChangeNotifierProvider(create: (_) => ProfileService()),
        ChangeNotifierProvider(create: (_) => ProfilegetService()),
        ChangeNotifierProvider(create: (_) => GetProfileResponse()),
        ChangeNotifierProvider(create: (_) => PostService()),
        ChangeNotifierProvider(create: (_) => PostgetService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RECONET',
        initialRoute: 'register',
        color: Colors.white,
        routes: appRoutes,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
