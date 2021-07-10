// To parse this JSON data, do
//
//     final PostResponse = PostResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/ipost_models.dart';

PostResponse postResponseFromJson(String str) =>
    PostResponse.fromJson(json.decode(str));

String postResponseToJson(Post data) => json.encode(data.toJson());

class PostResponse {
  PostResponse({this.ok, this.post, this.token});

  bool ok;
  Post post;
  String token;

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
      ok: json["ok"], post: Post.fromJson(json["post"]), token: json["token"]);

  Map<String, dynamic> toJson() =>
      {"ok": ok, "post": post.toJson(), "token": token};
}
