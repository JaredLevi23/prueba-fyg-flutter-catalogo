/*
  LISTA DESPLEGABLE MENU
  Muestra una lista desplegable con los tipos de productos Producto digital, Producto fisico o Servicio
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:catalogo_productos/src/providers/products_socket_service.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({Key? key}) : super(key: key);

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  String dropdownValue = 'Producto digital';

  @override
  Widget build(BuildContext context) {
    final productSocket = Provider.of<ProductsSocketService>(context); // Instancia de provider 
    
    return  Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tipo de producto', style: TextStyle(fontSize: 17),),
                DropdownButton<String>(            
                  value: productSocket.selectedProduct.type,
                  borderRadius: BorderRadius.circular(20),
                  underline: Container(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue ?? '';       
                      
                      final productSocket = Provider.of<ProductsSocketService>(context, listen: false);
                      productSocket.selectedProduct.type = newValue ?? ''; // Cambia el tipo de producto seleccionado
                    });
                  },
                  items: <String>['Producto digital', 'Producto fisico', 'Servicio']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontSize: 17),),
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }
}