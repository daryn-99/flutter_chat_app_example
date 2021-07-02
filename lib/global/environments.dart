import 'dart:io';

//Conexion con el servidor
class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'http://10.146.1.109:3000/api'
      : 'http://10.146.1.109:3000/api';
  static String socketUrl = Platform.isAndroid
      ? 'http://10.146.1.109:3000'
      : 'http://10.146.1.109:3000';
}
