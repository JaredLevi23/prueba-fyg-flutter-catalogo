/*
  Esta clase nos permite utilizar la comunicacion en tiempo real con socket.io
  utilizando su paquete de socket.io-client-dart 
  https://pub.dev/packages/socket_io_client/
 */
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:catalogo_productos/src/env.dart';
import 'package:catalogo_productos/src/models/product_model.dart';
 
class ProductsSocketService with ChangeNotifier {
  late ProductoModel selectedProduct; // Mantener la referencia al producto que seleccionemos
  late IO.Socket _socket;

  // Exponemos el socket para usarlo en cualquier lugar
  IO.Socket get socket => _socket;

  //Exponemos el emit para usarlo en cualquier lugar
  Function get emit => _socket.emit;
 
  //Constructor -> Inicializa el socket cuando se crea por primera vez
  ProductsSocketService(){
    _initConfig();
  }

  //Configuracion inicial para conectarse al servidor y poder escuchar eventos
  void _initConfig() {

    String urlSocket = miUrl; // la ip o url del servidor

    _socket = IO.io(
        urlSocket,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect() // se conecta automaticamente 
            .setExtraHeaders({'foo': 'bar'}) 
            .build()
    );

    // Estado Conectado
    _socket.onConnect((_) {
      print('Conectado por Socket');
      //notifyListeners();
    });

    // Estado Desconectado
    _socket.onDisconnect((_) {
      print('Desconectado del Socket Server');
      //notifyListeners();
    });
    
    //_socket.connect();//Conectamos al socket
  }

  //Conectar
  socketConnnect(){
    _socket.connect();
    notifyListeners();
  }
}