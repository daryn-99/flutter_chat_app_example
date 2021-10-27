import 'dart:convert';

import 'package:chat/global/environments.dart';
import 'package:chat/models/getprofile_response.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/profile.dart';
import 'package:chat/models/register_response.dart';
import 'package:chat/models/role_model.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  Profile profile;
  Role roles;
  bool _autenticando = false;

  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  final baseurl = Environment.apiUrl;

  var log = Logger();
  Future get(String url) async {
    final token = await _storage.read(key: 'token');

    url = formater(url);
    final uri = Uri.parse('$url');
    final response = await http.get(uri,
        headers: {'Content-Type': 'application/json', 'x-token': token});
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imgUrl) {
    String url = formater("/storage/$imgUrl");
    log.i(url);
    return NetworkImage(url);
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    url = formater(url);
    final token = await _storage.read(key: 'token');
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath("coverImage", filepath));
    request.headers
        .addAll({"Content-type": "multipart/form-data", 'x-token': token});
    var response = request.send();
    return response;
  }

  Future<http.StreamedResponse> patchImage1(String url, String filepath) async {
    url = formater(url);
    final token = await _storage.read(key: 'token');
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("imgUrl", filepath));
    request.headers
        .addAll({"Content-type": "multipart/form-data", 'x-token': token});
    var response = request.send();
    return response;
  }

  Future<http.StreamedResponse> patchImage2(String url, String filepath) async {
    url = formater(url);
    final token = await _storage.read(key: 'token');
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("imgUrl", filepath));
    request.headers
        .addAll({"Content-type": "multipart/form-data", 'x-token': token});
    var response = request.send();
    return response;
  }

  Future<http.Response> patch(String url, Map<String, String> body) async {
    String token = await _storage.read(key: "token");
    url = formater(url);
    log.d(body);
    final uri = Uri.parse('$url');
    var response = await http.patch(
      uri,
      headers: {"Content-type": "application/json", 'x-token': token},
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> put(String url, Map<String, String> body) async {
    String token = await _storage.read(key: "token");
    url = formater(url);
    log.d(body);
    final uri = Uri.parse('$url');
    var response = await http.put(
      uri,
      headers: {"Content-type": "application/json", 'x-token': token},
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> patch1(String url, Map<String, String> body) async {
    url = formater(url);
    log.d(body);
    final uri = Uri.parse('$url');
    var response = await http.patch(
      uri,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> delete(String url, Map<String, String> body) async {
    String token = await _storage.read(key: "token");
    url = formater(url);
    log.d(body);
    final uri = Uri.parse('$url');
    var response = await http.delete(
      uri,
      headers: {"Content-type": "application/json", 'x-token': token},
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    final token = await _storage.read(key: 'token');
    url = formater(url);
    log.d(body);
    final uri = Uri.parse('$url');
    var response = await http.post(
      uri,
      headers: {"Content-type": "application/json", 'x-token': token},
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> post1(String url, var body) async {
    final token = await _storage.read(key: 'token');
    url = formater(url);
    log.d(body);
    final uri = Uri.parse('$url');
    var response = await http.post(
      uri,
      headers: {"Content-type": "application/json", 'x-token': token},
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> deleter(String url, var body) async {
    final token = await _storage.read(key: 'token');
    url = formater(url);
    log.d(body);
    final uri = Uri.parse('$url');
    var response = await http.delete(
      uri,
      headers: {"Content-type": "application/json", 'x-token': token},
      body: json.encode(body),
    );
    return response;
  }

  // Getters del token de forma estatica
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  //Borrar token
  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password};

    final uri = Uri.parse('${Environment.apiUrl}/login');
    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(
      String username,
      String nombre,
      String apellido,
      String numerotel,
      String birth,
      String cargo,
      String area,
      //String role,
      String email,
      String password,
      String imgUrl) async {
    this.autenticando = true;

    final data = {
      'username': username,
      'nombre': nombre,
      'apellido': apellido,
      'numerotel': numerotel,
      'birth': birth,
      //'role': role,
      'cargo': cargo,
      'area': area,
      'email': email,
      'password': password,
      'imgUrl': imgUrl
    };
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/login/new');
    final resp = await http.post(uri,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'x-token': token});

    this.autenticando = false;
    if (resp.statusCode == 200) {
      final registerResponse = registerResponseFromJson(resp.body);
      this.usuario = registerResponse.usuario;

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    final resp = await http.get(Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': token});

    print(resp.body);
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);

      //Guardar token en lugar seguro

      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

  Future<Profile> getProfiles() async {
    try {
      final resp = await http.get(
          Uri.parse('${Environment.apiUrl}/profile/checkprofiles'),
          headers: {
            'Content-Type': 'application/json',
            //'x-token': await AuthService.getToken()
          });

      final profileResponse = getprofileResponseFromJson(resp.body);

      return profileResponse.profiles;
    } catch (e) {
      return null;
    }
  }
}
