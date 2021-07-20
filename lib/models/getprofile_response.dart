// To parse this JSON data, do
//
//     final usuariosResponse = usuariosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/profile.dart';
import 'package:flutter/cupertino.dart';

GetProfileResponse getprofileResponseFromJson(String str) =>
    GetProfileResponse.fromJson(json.decode(str));

String getprofileResponseToJson(GetProfileResponse data) =>
    json.encode(data.toJson());

class GetProfileResponse with ChangeNotifier {
  GetProfileResponse({
    this.ok,
    this.profiles,
  });

  bool ok;
  Profile profiles;

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) =>
      GetProfileResponse(
        ok: json["ok"],
        profiles:
            Profile.fromJson(json["profiles"].map((x) => Profile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "profiles": profiles.toJson(),
      };
}
