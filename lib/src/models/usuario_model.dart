/*
Modelo del producto para tratar la informacion que recibimos del endpoint 
*/

import 'dart:convert';

class UsuarioModel {
    UsuarioModel({
        required this.ok,
        required this.googleUser,
    });

    bool ok;
    GoogleUser googleUser;

    factory UsuarioModel.fromJson(String str) => UsuarioModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsuarioModel.fromMap(Map<String, dynamic> json) => UsuarioModel(
        ok: json["ok"],
        googleUser: GoogleUser.fromMap(json["googleUser"]),
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "googleUser": googleUser.toMap(),
    };
}

class GoogleUser {
    GoogleUser({
        required this.name,
        required this.picture,
        required this.email,
    });

    String name;
    String picture;
    String email;

    factory GoogleUser.fromJson(String str) => GoogleUser.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GoogleUser.fromMap(Map<String, dynamic> json) => GoogleUser(
        name: json["name"],
        picture: json["picture"],
        email: json["email"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "picture": picture,
        "email": email,
    };
}
