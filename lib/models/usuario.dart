// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.online,
    this.username,
    this.nombre,
    this.apellido,
    this.numerotel,
    this.birth,
    //this.role,
    this.cargo,
    this.area,
    this.email,
    this.uid,
  });

  bool online;
  String username;
  String nombre;
  String apellido;
  String numerotel;
  String birth;
  //List<String> role = [];
  String cargo;
  String area;
  String email;
  String uid;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        username: json["username"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        numerotel: json["numerotel"],
        birth: json["birth"],
        //role: json["role"],
        cargo: json["cargo"],
        area: json["area"],
        email: json["email"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "online": online,
        "username": username,
        "nombre": nombre,
        "apellido": apellido,
        "numerotel": numerotel,
        "birth": birth,
        //"role": role,
        "cargo": cargo,
        "area": area,
        "email": email,
        "uid": uid,
      };
}
