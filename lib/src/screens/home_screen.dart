/*
  Pantalla en donde se muestran los productos creados por todos
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:catalogo_productos/src/models/product_model.dart';
import 'package:catalogo_productos/src/providers/products_socket_service.dart';
import 'package:catalogo_productos/src/shar_pref/shared_preferences.dart';
import 'package:catalogo_productos/src/widgets/widgets.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //Lista de productos creados por todos
  List<ProductoModel> products = [];

  @override
  void initState() {
    
    //Se ejecuta cuando ya se creo todo el widget
    WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {
    //Cuando el widget se incorpora al contexto, comieza a escuchar lo que emita el servidor con el nombre de productos-registrados
    //Se usa el provider de product_socket_service, sin escuchar cambios 
      final productSocket = Provider.of<ProductsSocketService>(context, listen: false);
      productSocket.socketConnnect();
      productSocket.socket.on('productos-registrados', _loadData); //Escuchando productos-registrados del servidor
    }));

    super.initState();
  }

  // Metodo para recibir la respuesta del servidor y tratar la informacion
  _loadData(dynamic resp) { //Recibe un JSON 
    products = (resp as List) // trata a la respuesta como una lista
        .map((product) => ProductoModel.fromMap(product)) // crea un mapa con cada elemento del JSON y lo trata como un producto
        .toList(); // convierte el mapa a una lista

    if( !mounted ) return; // Verifica si el widget ya existe en el contexto, para poder usar el setState
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    // Preparamos el provider y las preferemcias de usuario
    final productSocket = Provider.of<ProductsSocketService>(context);
    final prefs = UserPreferences(); //singleton ( Preferencias de usuario )

    return Scaffold(
        appBar: AppBar(
          title: const Text('Catalogo'),
        ),
        
        drawer: CustomDrawer(), // widget menu lateral izquierdo, /widgets/custom_drawer.dart

        // Boton flotante para agregar un producto
        floatingActionButton: FloatingActionButton(
          elevation: 2,
          child: const Icon(
            Icons.add,
            color: Colors.blue,
            size: 28,
          ),
          backgroundColor: Colors.white,
          onPressed: () {

            // Asigna el producto seleccionado como un nuevo producto en blanco
            productSocket.selectedProduct = ProductoModel(
              id: '', 
              name: '', 
              description: '', 
              price: '',
              create: prefs.name.toString(), // Nombre del usuario de las preferencias de usuario
              type: 'Producto digital'
            );

             //Navega a la pantalla de la creacion o edicion de producto
            Navigator.pushNamed(context, 'create'); // /screens/create_screen.dart
          },
        ),

        // Se construye la lista de los productos 
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: products.length, //Cantidad de productos
            itemBuilder: (context, indice){ 
              // widget que construye n veces segun los productos  
                return GestureDetector(
                  child: CustomCardItem( // widget ( resutilizable) /widgets/custom_card_item.dart
                    producto: products[indice] // Recibe el producto de la lista 
                  )
                );
            }
        
        )
    );
  }
}
