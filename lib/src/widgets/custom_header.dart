/*
  ICONO DEL CARRITO CON UN TEXTO

*/

import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {

  final String title ; 
  const CustomHeader({Key? key, 
    required this.title // requiere el texto
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
            SizedBox( height: MediaQuery.of(context).size.height*0.1),
            Icon(Icons.shopping_cart, color: Colors.blue, size: MediaQuery.of(context).size.height * 0.2,),

            Center( child:Text( 
              title, // Muestra el texto
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            ),

            const SizedBox( height: 25,),
        ],
      ),
    );
  }
}