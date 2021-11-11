import 'package:chat/global/environments.dart';
import 'package:chat/models/getprofile_response.dart';
import 'package:chat/models/profile.dart';
import 'package:chat/models/profile_response.dart';
import 'package:chat/services/respuesta_perfil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth_services.dart';

class ProfilegetService with ChangeNotifier {
  Future<Profile> getProfiles() async {
    try {
      final resp = await http
          .get(Uri.parse('${Environment.apiUrl}/profile/get'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });

      final profileResponse = getprofileResponseFromJson(resp.body);

      return profileResponse.profiles;
    } catch (e) {
      return null;
    }
  }

  Future<List<Profile>> getListProfiles() async {
    try {
      final resp = await http.get(
          Uri.parse('${Environment.apiUrl}/profile/checkprofiles'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          });

      final profileResponse = respuestaPerfilFromJson(resp.body);

      return profileResponse.profile;
    } catch (e) {
      return [];
    }
  }
}
