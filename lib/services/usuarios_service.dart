import 'dart:convert';

import 'package:chat/global/environments.dart';
import 'package:chat/helpers/motrar_alerta.dart';
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

  Future<Usuario> deleteUser(String userId) async {
    print(userId);
    final response = await http.delete(
      Uri.parse('${Environment.apiUrl}/usuarios/delete/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      print('a'); //Usuario.fromJson(jsonDecode(response.body)['usuario']);
    } else {
      print(response.statusCode);
      throw Exception('Error al eliminar el usuario');
    }
  }

  Future<Usuario> modifyUser(String userId, Map<String, String> body) async {
    print(userId);
    var body = json.encode(Usuario());
    print(body);
    final response = await http.put(
        Uri.parse('${Environment.apiUrl}/usuarios/updateUser/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
        body: body);

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body)['usuario']);
    } else {
      print(response.statusCode);
      throw Exception('Error al modificar el usuario');
    }
  }
}
