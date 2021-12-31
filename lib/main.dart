/*
  Punto inicial de la aplicacion 
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:catalogo_productos/src/providers/products_socket_service.dart';
import 'package:catalogo_productos/src/shar_pref/shared_preferences.dart';
import 'package:catalogo_productos/src/screens/screens.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); //Llama la instancia de WidgetBinding ( inicia la app antes de MyApp)
  final prefs = UserPreferences(); // Singleton de las preferencias de usuario
  await prefs.initPrefs(); // Cargamos la instancia de las preferencias de usuario

  runApp(MyApp()); // Corre MyApp
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final prefs = UserPreferences(); // Instancia de las preferencias de usuario ( Singleton )

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ( _ ) => ProductsSocketService(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: prefs.screen, // De las preferencias usa la ruta guardada si no existe retorna un login
          routes: {
            //Rutas de las pantallas 
            'login': (_) => LoginScreen(),
            'register': (_) => RegisterScreen(),
            'home': (_) =>  const HomeScreen(),
            'create' : ( _ ) => CreateScreen()
          },
      ),
    );
  }
}
