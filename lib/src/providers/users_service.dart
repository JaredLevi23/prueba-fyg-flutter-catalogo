/*
  Esta clase permite autenticarse con el servidor con el registro propio 
  de la aplicacion utilizando el paquete de http
  
 */

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:catalogo_productos/src/env.dart';
import 'package:catalogo_productos/src/models/usuario_model.dart';
import 'package:catalogo_productos/src/shar_pref/shared_preferences.dart';

class UserService{

  final prefs = UserPreferences(); // Obtenemos la instancia de las preferencias de usuario
  final _baseUrl = '$miUrl/api'; // url del servidor 


  UserService(){
    print('inicializando servicio') ;
  }

  // Metodo que nos permite registrarnos en el servidor con un nombre, un correo y una contraseña
  Future<bool> register( String email, String password, String nombre ) async{

    //Hacemos la peticion al servidor con un POST a la ruta de users, con los datos en el body
    final resp =  await http.post(
        Uri.parse('$_baseUrl/users'), 
        body: jsonEncode( { 
          'email':email.trim(), 
          'password':password, 
          'nombre':nombre.trim() 
        }),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        }
    );

    // Si el servidor contiene un mensaje es por que hubo un error
    if(resp.body.contains('msg')){
      return false;//Retornamos para no seguir con lo siguiente
    }

    //el servidor nos da una respuesta y la tratamos como un obteto del UserModel
    final user = UsuarioModel.fromJson( resp.body );
    //Almacena las preferencias de usuario
    prefs.name = user.googleUser.name;
    prefs.email = user.googleUser.email;
    prefs.photo = '';
    prefs.screen = 'home';
    
    return true;//hubo exito al registrarnos
  }


  //Metodo para loggearnos en la aplicacion, necesita el correo y la contraseña
  Future login<bool>(String email, String password)async{

    // Se realiza la peticion al servidor con un POST a la ruta de login, enviando los argumentos en el body
    final resp = await http.post(
      Uri.parse('$_baseUrl/login'),
      body: jsonEncode( { 
          'email':email.trim(), 
          'password':password, 
        }),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        }
    );

    // Si el servidor contiene un mensaje es por que hubo un error
    if( resp.body.contains('msg')){
      return false; // retornamos un falso deteniendo lo siguiente
    }

    //el servidor nos da una respuesta y la tratamos como un obteto del UserModel
    final user = UsuarioModel.fromJson( resp.body );

    //Almacena las preferencias de usuario
    prefs.name = user.googleUser.name;
    prefs.email = user.googleUser.email;
    prefs.photo = user.googleUser.picture;
    prefs.screen = 'home';

    return true; //Exito al loggearnos
  }






}