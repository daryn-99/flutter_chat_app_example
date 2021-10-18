// // To parse this JSON data, do
// //
// //     final roleResponse = roleResponseFromJson(jsonString);

// import 'dart:convert';

// import 'package:chat/models/role_model.dart';
// import 'package:chat/models/usuario.dart';

// RoleResponse roleResponseFromJson(String str) =>
//     RoleResponse.fromJson(json.decode(str));

// String roleResponseToJson(RoleResponse data) => json.encode(data.toJson());

// class RoleResponse {
//   RoleResponse({
//     this.ok,
//     this.role,
//   });

//   bool ok;
//   List<Role> role;

//   factory RoleResponse.fromJson(Map<String, dynamic> json) => RoleResponse(
//         ok: json["ok"],
//         role: List<Role>.from(json["role"].map((x) => Usuario.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "ok": ok,
//         "role": List<dynamic>.from(role.map((x) => x.toJson())),
//       };
// }
