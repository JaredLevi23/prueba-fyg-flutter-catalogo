/*
  MENSAJE DE ALERTA
  Mensaje de alerta personalizado que recibe una cadena y un booleano

*/

import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String message;
  final bool error;

  const CustomDialog({Key? key, 
    required this.message,  // Requeridos
    required this.error // Requeridos
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       title: error  // Ternario para mostrar un icono 
       ? const CircleAvatar(child: Icon( Icons.error, color: Colors.white, ), backgroundColor: Colors.red,)
       : const CircleAvatar(child: Icon( Icons.check )),
       content: Text(message, textAlign: TextAlign.center,), // Muestra el mensaje
       
    );
  }
}