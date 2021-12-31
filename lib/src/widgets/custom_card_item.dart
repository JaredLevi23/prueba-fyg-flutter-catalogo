/*
  ELEMENTO DE LA LISTA DE PRODUCTOS 
  Widget personalizado que se muestra los productos en la lista
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:catalogo_productos/src/models/product_model.dart';
import 'package:catalogo_productos/src/providers/products_socket_service.dart';

class CustomCardItem extends StatelessWidget {
  final ProductoModel producto; // Producto 
  const CustomCardItem({
    Key? key, 
    required this.producto // Producto requerido 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.only(top: 15),
        child: SizedBox(
          height: 80,
          child: Center(
            child: ListTile(
              title: Text( producto.name ), // Muestra el nombre del producto
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text( producto.type, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold), ),
                  Text( producto.description, maxLines: 2, overflow: TextOverflow.ellipsis, ),
                ],
              ), // Muestra la descripcion del producto
              trailing: CircleAvatar(
                radius: 35,
                child: Text('\$'+producto.price, style: TextStyle( fontSize: producto.price.length>5 ? 9 : 15,),) // Muestra el precio del producto
              ),
            ),
          ),
        ),
      ),

      onTap: (){
        
        final productService = Provider.of<ProductsSocketService>(context, listen: false); // Instancia de provider sin escuchar cambios
        productService.selectedProduct = producto.copy(); // Se pasa el producto seleccionado para editar o eliminar

        showDialog(context: context, builder: (context){
          
          return AlertDialog(
            //Muestra informacion del producto 

            title: Text(producto.name), // Nombre del producto
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const Text('Tipo de producto', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(producto.type), // Tipo de producto
                  const Text('\nDescripción', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(producto.description), // Descripcion del producto
                  const Text('\nPrecio', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('\$' + producto.price), // Precio
                  const Text('\nCreado por', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(producto.create ?? 'No se sabe'), // Quien lo hizo
                  
                ],
              ),
            ),
            actions: [
              
              TextButton( // Boton 
                onPressed: (){
                  // emite al servidor borrar-producto
                  productService.socket.emit('borrar-producto', { 'id': producto.id }); // Envia el id ( payload )
                  Navigator.pop(context);
                }, 
                child: const Text('Borrar')
              ),

              TextButton( // Boton
                onPressed: (){
                  Navigator.pop(context); 
                  // Navega a la pantalla de creacion o edicion de producto
                  Navigator.pushNamed(context, 'create');  // /screens/create_screen.dart 
                }, 
                child: const Text('Editar')
              ),
            ],
          );
        });
      },
    );
  }
}