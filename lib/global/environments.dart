import 'dart:io';

//Conexion con el servidor
class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.80.124:3000/api'
      : 'http://192.168.80.124:3000/api';
  static String socketUrl = Platform.isAndroid
      ? 'http://192.168.80.124:3000'
      : 'http://192.168.80.124:3000';
}
