/*
  Clase con singleton para las preferencias de usuario
  Guarda: nombre, correo, foto, ruta de pantalla 

  paquete: shared_preferences
  https://pub.dev/packages/shared_preferences/example
*/

import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{

  // Definicion del singleton 
  static final UserPreferences _instance = UserPreferences._internal();
  UserPreferences._internal();
  factory UserPreferences(){
    return _instance;
  }

  late SharedPreferences _prefs; // Clase del paquete 

  initPrefs()async{ // Metodo para obtener la instancia de las preferencias de usuario
    _prefs = await SharedPreferences.getInstance();  
  }

  
  String get photo => _prefs.getString('photo') ?? ''; //Obteniene la foto de las preferencias 

  set photo(String photo) { // Guarda la foto en las preferencias 
     _prefs.setString('photo', photo);
  }
  
  String get name => _prefs.getString('name') ?? '' ; // Obtiene el nombre de las preferencias

  set name(String name) {
    _prefs.setString('name', name); // Guarda el nombre en las preferencias
  }
  
  String get email => _prefs.getString('email') ?? ''; //Obtiene el email

  set email(String email) {
    _prefs.setString('email', email); // Guarda el email
  }

  String get screen => _prefs.getString('screen') ?? 'login'; // Obtiene la ruta
  set screen ( String screen ){
    _prefs.setString('screen', screen); // Envia la ruta
  }

}