// To parse this JSON data, do
//
//     final role = roleFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'role_model.g.dart';

@JsonSerializable()
// Role roleFromJson(String str) => Role.fromJson(json.decode(str));

// String roleToJson(Role data) => json.encode(data.toJson());

class Role {
  Role({this.name});

  String name;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);

  // factory Role.fromJson(Map<String, dynamic> json) => Role(
  //       name: json["name"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "name": name,
  //     };
}
