// To parse this JSON data, do
//
//     final Post = PostFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({this.title, this.caption, this.coverImage});

  String title;
  String caption;
  String coverImage;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      title: json["title"],
      caption: json["caption"],
      coverImage: json["coverImage"]);

  Map<String, dynamic> toJson() =>
      {"title": title, "caption": caption, "coverImage": coverImage};
}
