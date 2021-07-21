// To parse this JSON data, do
//
//     final Post = PostFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'ipost_models.g.dart';

@JsonSerializable()

// Post postFromJson(String str) => Post.fromJson(json.decode(str));

// String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({this.title, this.caption, this.coverImage});

  String title;
  String caption;
  String coverImage;
  // int count;
  // int comment;

  // factory Post.fromJson(Map<String, dynamic> json) => Post(
  //     title: json["title"],
  //     caption: json["caption"],
  //     coverImage: json["coverImage"]);

  // Map<String, dynamic> toJson() =>
  //     {"title": title, "caption": caption, "coverImage": coverImage};

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
