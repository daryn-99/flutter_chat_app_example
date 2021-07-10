import 'dart:convert';

import 'package:chat/global/environments.dart';
import 'package:chat/models/ipost_models.dart';
import 'package:chat/models/post_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostgetService with ChangeNotifier {
  Post post;
  Future<Post> getPost() async {
    try {
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/post/get'),
          headers: {'Content-Type': 'application/json'});

      final postResponse = postResponseFromJson(resp.body);

      return postResponse.post;
    } catch (e) {
      return null;
    }
  }
}
