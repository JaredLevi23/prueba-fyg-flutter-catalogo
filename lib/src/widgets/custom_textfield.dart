/*
   ENTRADA DE TEXTO
  Entrada de texto personalizada 

 */

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final IconData icon; // Obligatorios 
  final String label; // Obligatorios 
  final bool isPassword; // Obligatorios 
  TextEditingController? controller;
  TextInputType? textType = TextInputType.text;
  String? initialValue;
  Function(String)? onChanged;
  String Function(String?)? validator;
  int ?maxlines;

  CustomTextField({
    Key? key, 
    required this.icon,  // icono del campo de texto OBLIGATORIOS
    required this.label, //etiqueta del campo de texto OBLIGATORIOS
    required this.isPassword,  // oculta caracteres  OBLIGATORIOS
    this.controller, // controlador opcional
    this.textType, // tipo de texto opcional 
    this.initialValue, // valor inicial opcional 
    this.onChanged, // funcion onChange(value) al cambiar texto opcional 
    this.validator, // funcion validacion ()=>string al cambiar texto opcional  
    this.maxlines
  }) : super(key: key);  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(right: 15),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade300
      ),

      child: TextFormField(
        controller: controller, // Uso del controlador
        initialValue: initialValue, // Uso del valor inicial
        keyboardType: textType, // Uso del tipo de texto ( teclado )
        obscureText: isPassword, // Ocultar texto
        validator: validator, // Uso de validator 
        autovalidateMode: AutovalidateMode.onUserInteraction, // Validar al cambiar

        cursorRadius: const Radius.circular(20),
        style: const TextStyle(fontSize: 18),
        maxLines: maxlines ?? 1,
        onChanged: onChanged, // Funcion al cambiar
        
        decoration: InputDecoration(
          label: Text(label), // etiqueta
          prefixIcon: Icon( icon ), //icono
          border: InputBorder.none,
        ),
        
      ),

    );
  }
}