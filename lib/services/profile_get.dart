import 'dart:convert';

import 'package:chat/global/environments.dart';
import 'package:chat/models/profile.dart';
import 'package:chat/models/profile_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilegetService with ChangeNotifier {
  Profile profile;
  Future<Profile> getProfiles() async {
    try {
      final resp = await http.get(
          Uri.parse('${Environment.apiUrl}/profile/checkprofiles'),
          headers: {'Content-Type': 'application/json'});

      final profileResponse = profileResponseFromJson(resp.body);

      return profileResponse.profile;
    } catch (e) {
      return null;
    }
  }
}
