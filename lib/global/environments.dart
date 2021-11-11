import 'dart:io';

//Conexion con el servidor
class Environment {
  static String apiUrl = Platform.isWindows
      ? 'https://reconet.recoroatan.com/api'
      : 'https://reconet.recoroatan.com/api';
  static String socketUrl = Platform.isAndroid
      ? 'https://reconet.recoroatan.com/'
      : 'https://reconet.recoroatan.com/';
  static String pcUrl = Platform.isWindows
      ? 'https://reconet.recoroatan.com/'
      : 'https://reconet.recoroatan.com/';
}
