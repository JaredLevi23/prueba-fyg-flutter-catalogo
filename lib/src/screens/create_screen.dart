/*
  Pantalla en donde se crean los nuevos productos
  o 
  se editan los existentes

  **Este registro es volatil cuando se baja el servidor**
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:catalogo_productos/src/providers/products_socket_service.dart';
import 'package:catalogo_productos/src/validators/validator.dart';
import 'package:catalogo_productos/src/widgets/widgets.dart';

class CreateScreen extends StatelessWidget {
  
  String dropdownValue = 'Producto fisico';
  CreateScreen({Key? key}) : super(key: key);
  final validate = Validator();//Clase para validar campos ( es un correo? es un numero?)

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsSocketService>(context);// Instancia de provider 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de producto'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 25,),
          const Icon(Icons.shopping_cart, size: 40, color: Colors.blue,),
          const SizedBox(height: 10,),
          Center(
            child: Text(
                productService.selectedProduct.id == '' //Ternario para poner un titulo
                    ? 'Nuevo producto'
                    : 'Editando'
            , style: const TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 15,),

          // Muestra el id del producto que seleccionamos o estamos creando
          Center(
              child: Text(
                'ID: ${productService.selectedProduct.id == '' ? 'Sin asignar' : productService.selectedProduct.id}'
              )
          ),

          const CustomDropDownMenu(), // Lista desplegable de tipo de producto

          //Desplegar la informacion del prodcuto seleccionado en los campos de texto
          // Es el mismo widget con diferentes propiedades del producto
          CustomTextField(// widget( reutilizado ) /widgets/custom_textfield.dart
              icon: Icons.add_shopping_cart_sharp,
              label: 'Nombre',
              isPassword: false,
              initialValue: productService.selectedProduct.name,
              onChanged: (value) {
                productService.selectedProduct.name = value;
              }),
          CustomTextField(// widget( reutilizado ) /widgets/custom_textfield.dart
              icon: Icons.format_line_spacing_rounded,
              label: 'Descripcion',
              maxlines: 3,
              isPassword: false,
              initialValue: productService.selectedProduct.description,
              onChanged: (value) {
                productService.selectedProduct.description = value;
              }),
          CustomTextField(// widget( reutilizado ) /widgets/custom_textfield.dart
              icon: Icons.monetization_on,
              label: 'Precio',
              isPassword: false,
              textType: TextInputType.number,
              initialValue: productService.selectedProduct.price.toString(),
              onChanged: (value) {
                productService.selectedProduct.price = value;
              },
              validator: (value){
                if (validate.isNumber(value ?? 'a') == false) {
                  return '        Esto no es un numero';
                }
                return '';
              },
          ),

          SizedBox(
            width: double.infinity,
            child: CustomButton( // widget( reutilizado ) /widgets/custom_button.dart
                label: 'Guardar',
                onPressed: () {

                  //Verifica que los campos no esten vacios del producto creado o editado
                  if (productService.selectedProduct.name.trim().length > 1 &&
                      productService.selectedProduct.description.trim().length >1 &&
                      productService.selectedProduct.price != '' ) {

                    //Verifica que el precio sea un numero
                    if( validate.isNumber( productService.selectedProduct.price ) == false){
                      return showDialog(context: context, builder: (context) => const CustomDialog(
                        error: true,
                        message: 'El precio debe ser un numero',
                      ));
                    }

                    // Se usa el provider del product_socket_service
                    final productSocket = Provider.of<ProductsSocketService>(context,listen: false); // Instancia de provider, listen false por que esta dentro de una funcion

                    // Si el id esta vacio entonces se esta creando un producto
                    if(productService.selectedProduct.id == '' ){
                      productSocket.emit('producto-nuevo', { //emite al servidor que hay un producto nuevo
                        //Propiedades del producto
                        "name": productService.selectedProduct.name,
                        "description": productService.selectedProduct.description,
                        "price": productService.selectedProduct.price.toString(),
                        "create": productService.selectedProduct.create,
                        "type": productService.selectedProduct.type
                      });
                    }else{
                    // Si el id NO esta vacio, entonces se esta editando un producto
                      productSocket.emit('producto-actualizado', { //emite al servidor que se actualizo un producto
                        //Propiedades del producto
                        "id" : productService.selectedProduct.id,
                        "name": productService.selectedProduct.name,
                        "description": productService.selectedProduct.description,
                        "price": productService.selectedProduct.price.toString(),
                        "type": productService.selectedProduct.type
                      });
                    }

                    // Regresa a la pantalla anterior
                    Navigator.pop(context);
                  }else{
                    //Se lanza si algun campo esta vacio
                    showDialog(context: context, builder: (context) => const CustomDialog(
                        error: true,
                        message: 'Todos los campos son obligatorios',
                      ));
                  }
                }),
          ),

          const SizedBox(height: 25,)
        ],
      ),
    );
  }

 
}
