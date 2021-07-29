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
  Post(
      {this.count,
      this.comment,
      this.id,
      this.user,
      this.title,
      this.coverImage});

  int count;
  int comment;
  @JsonKey(name: '_id')
  String id;
  String user;
  String title;
  String coverImage;

  // factory Post.fromJson(Map<String, dynamic> json) => Post(
  //     title: json["title"],
  //     caption: json["caption"],
  //     coverImage: json["coverImage"]);

  // Map<String, dynamic> toJson() =>
  //     {"title": title, "caption": caption, "coverImage": coverImage};

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
