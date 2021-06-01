import 'package:chat/global/environments.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'auth_services.dart';

class ChatService with ChangeNotifier {
  //Para quien van los mensajes
  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    try {
      final resp = await http.get(
          Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          });

      final mensajesResp = mensajesResponseFromJson(resp.body);

      return mensajesResp.mensajes;
    } catch (e) {
      return [];
    }
  }
}
