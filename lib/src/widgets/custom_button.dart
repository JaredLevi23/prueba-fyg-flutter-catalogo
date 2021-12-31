
/*
  BOTON PERSONALIZADO 
  Widget retuilizable que recibe una etiqueta o titulo y una funcion 
*/

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const CustomButton({Key? key, 
  required this.label, // titulo REQUERIDO
  required this.onPressed // funcion REQUERIDA
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20)
      ),
      child: TextButton(
        onPressed: onPressed, //Asigna la funcion
        child: Text(
          label, //Asigna el titulo
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
    );
  }
}