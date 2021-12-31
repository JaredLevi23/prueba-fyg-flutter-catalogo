/*
  BUTTON GOOGLE
  Este boton nos permite iniciar sesion con nuestra cuenta de google, solo android :( 
 */
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:catalogo_productos/src/providers/auth_google.dart';
import 'package:catalogo_productos/src/widgets/widgets.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.red.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.account_box, color: Colors.white),
          SizedBox(width: 5,),
          Text('Iniciar sesión con Google', style: TextStyle(color: Colors.white),),
        ],
      ),
      onPressed:()async{
        try{

          if( !Platform.isIOS ){ // Si la plataforma no es en IOS
            final sesion = await AuthGoogle.signInWithGoogle(); // utiliza el metodo de la clase AuthGoogle /providers/auth_google.dart
            if( sesion != null){ // Si la sesion fue exitosa
              Navigator.pushReplacementNamed(context, 'home'); // Navegamos al inicio /screens/home_screen.dart
            }else{
              showDialog(context: context, builder: (context){
                return const CustomDialog(
                  error: true,
                  message: 'No selecciono una cuenta',
                );
              });  
            }
          }else{
            showDialog(context: context, builder: (context){
              return const CustomDialog(
                error: true,
                message: 'Esta opcion solo se configuro para Android :( ',
              );
            });
          }
          
        }
        catch(e){
          showDialog(
            context: context, 
            builder: (context){
              return const AlertDialog( 
                title: Text('No has iniciado con ninguna cuenta'),
              );
            }
          );
        }
      }
    );
  }
}