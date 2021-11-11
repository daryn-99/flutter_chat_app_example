// To parse this JSON data, do
//
//     final ProfileRespuesta = ProfileRespuestaFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/profile.dart';

ProfileRespuesta respuestaPerfilFromJson(String str) =>
    ProfileRespuesta.fromJson(json.decode(str));

String respuestaPerfilToJson(ProfileRespuesta data) =>
    json.encode(data.toJson());

class ProfileRespuesta {
  ProfileRespuesta({
    this.ok,
    this.profile,
    this.token,
  });

  bool ok;
  List<Profile> profile;
  String token;

  factory ProfileRespuesta.fromJson(Map<String, dynamic> json) =>
      ProfileRespuesta(
        ok: json["ok"],
        profile:
            List<Profile>.from(json["dato"].map((x) => Profile.fromJson(x))),
        //token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "dato": List<dynamic>.from(profile.map((x) => x.toJson())),
        //"token": token,
      };
}
