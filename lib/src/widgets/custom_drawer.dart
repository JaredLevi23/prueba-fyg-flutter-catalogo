/*
  MENU LATERAL
  Menu que muestra la informacion del usuario
 */

import 'package:catalogo_productos/src/providers/products_socket_service.dart';
import 'package:flutter/material.dart';
import 'package:catalogo_productos/src/providers/auth_google.dart';
import 'package:catalogo_productos/src/shar_pref/shared_preferences.dart';
import 'package:catalogo_productos/src/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);

  final prefs = UserPreferences(); // Instancia de las preferencias de usuario /shar_pref/shared_preferences.dart

  @override
  Widget build(BuildContext context) {
    
    final productSocket = Provider.of<ProductsSocketService>(context); // Llamamos al provider ProductScoket
    
    return Drawer(
      child: DrawerHeader(
        child: Column(
          children: [
            
            Row(
              children: [

                prefs.photo == '' // Ternario para determinar que foto o icono poner 
                ? const CircleAvatar(
                  radius: 35, 
                  child: Icon(Icons.person),
                  
                )

                : CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(prefs.photo), //  Imagen del usuario
                )
                ,


                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(prefs.name), // Muestra el nombre
                    Text(prefs.email), // Muestra el correo
                  ],
                )                

              ],
            ),

            const Spacer(),

            Container(
              margin: const EdgeInsetsDirectional.only(bottom: 10),
              width: double.infinity,
              child: CustomButton(
                label: 'Cerrar Sesión', 
                onPressed: () async{
                  productSocket.socket.disconnect(); // Desconecta el socket 

                  // Se sobreescriben las preferencias de usuario
                  prefs.email = '';
                  prefs.name = '';
                  prefs.photo = '';
                  prefs.screen = 'login';
                  await AuthGoogle.signOut(); // Se cierra la sesion de google

                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, 'login'); // Navega al inicio de sesion /screens/login_screen.dart
                }
              )
            )

          ],
        )
      ),
    );
  }
}