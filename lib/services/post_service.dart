import 'dart:convert';

import 'package:chat/global/environments.dart';
import 'package:chat/models/ipost_models.dart';
import 'package:chat/models/post_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth_services.dart';

class PostService with ChangeNotifier {
  Post post;
  Future poster(String title, String coverImage) async {
    final data = {'title': title, 'coverImage': coverImage};

    final uri = Uri.parse('${Environment.apiUrl}/post/new');
    final resp = await http.post(uri, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });

    print(resp.body);
    if (resp.statusCode == 200) {
      final postResponse = postResponseFromJson(resp.body);
      this.post = postResponse.post;
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }
}
