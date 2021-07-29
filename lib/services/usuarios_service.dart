import 'package:chat/global/environments.dart';
import 'package:chat/models/usuarios_response.dart';
import 'package:chat/services/auth_services.dart';
import 'package:http/http.dart' as http;

import 'package:chat/models/usuario.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/usuarios'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          });

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }

  Future<List<Usuario>> getAllUsuarios() async {
    try {
      final resp = await http
          .get(Uri.parse('${Environment.apiUrl}/usuarios/allusers'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });

      final allusuariosResponse = usuariosResponseFromJson(resp.body);

      return allusuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
