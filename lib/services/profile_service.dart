import 'dart:convert';

import 'package:chat/global/environments.dart';
import 'package:chat/models/profile.dart';
import 'package:chat/models/profile_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth_services.dart';

class ProfileService with ChangeNotifier {
  Profile profile;

  Future profiler(String about) async {
    final data = {'about': about};

    final uri = Uri.parse('${Environment.apiUrl}/profile/add');
    final resp = await http.post(uri, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });

    //print(resp.body);
    if (resp.statusCode == 200) {
      final profileResponse = profileResponseFromJson(resp.body);
      this.profile = profileResponse.profile;
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }
}
