// To parse this JSON data, do
//
//     final ProfileResponse = ProfileResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/profile.dart';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  ProfileResponse({
    this.ok,
    this.profile,
    this.token,
  });

  bool ok;
  Profile profile;
  String token;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        ok: json["ok"],
        profile: Profile.fromJson(json["profile"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "profile": profile.toJson(),
        "token": token,
      };
}
