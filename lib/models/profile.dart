// To parse this JSON data, do
//
//     final Profile = ProfileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.about,
    this.imgUrl,
  });

  String about;
  String imgUrl;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        about: json["about"],
        imgUrl: json["imgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "about": about,
        "imgUrl": imgUrl,
      };
}
