/*
  Clase que nos permite conectarnos con google utilizando su paquete de 
  google_sign_in
  https://pub.dev/packages/google_sign_in/
 */

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

import 'package:catalogo_productos/src/env.dart';
import 'package:catalogo_productos/src/models/usuario_model.dart';
import 'package:catalogo_productos/src/shar_pref/shared_preferences.dart';

class AuthGoogle{

  //Alcance de autenticacion, esta clase la brinda el paquete google_sign_in
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes:[
      'email',//Solo se utiliza el email para obtener informacion basica
    ],
  );

  //Autenticacion
  static Future<GoogleSignInAccount?> signInWithGoogle() async{
    try{

      //Abre el splash para seleccionar cuenta de google y espera hasta que seleccionemos o salgamos
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final googleKey = await account?.authentication;

      //Enviamos un POST al servidor con el token que nos genera google
      final sesion =  await http.post(
        Uri.parse('$miUrl/api/google'), 
        body: jsonEncode({"token": googleKey?.idToken}),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        }
      );

      //La respuesta del servidor es un JSON con la informacion basica del usuario ( session.body )
      //Tratamos esa respuesta como un objeto del UsuarioModel
      final userModel = UsuarioModel.fromJson( sesion.body );

      //Almacenamos el nombre, el correo, el url de la foto y la pagina donde iniciara la aplicacion ahora
      final  prefs = UserPreferences();
      prefs.name = userModel.googleUser.name;
      prefs.email = userModel.googleUser.email;
      prefs.photo = userModel.googleUser.picture;
      prefs.screen = 'home';

      return account;

    }catch( e ){
      //Sucede una excepsion si no se selecciona una cuenta
      //Se detiene solo en desarrollo, en produccion no pasa
      return null;
    }
  }

  //Cerrar sesion utulizando el metodo que nos proporciona el paquete de google_sign_in
  static Future signOut()async{
    _googleSignIn.signOut();
  }

}