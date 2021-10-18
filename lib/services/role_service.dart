// import 'dart:convert';

// import 'package:chat/global/environments.dart';
// import 'package:chat/models/role_model.dart';
// import 'package:chat/models/role_response.dart';
// import 'package:chat/services/auth_services.dart';
// import 'package:http/http.dart' as http;

// class RoleService {
//   Future<List<Role>> getRoles() async {
//     try {
//       final resp = await http
//           .get(Uri.parse('${Environment.apiUrl}/role/getrole'), headers: {
//         'Content-Type': 'application/json',
//         'x-token': await AuthService.getToken()
//       });

//       final roleResponse = roleResponseFromJson(resp.body);

//       return roleResponse.role;
//     } catch (e) {
//       return [];
//     }
//   }
// }
