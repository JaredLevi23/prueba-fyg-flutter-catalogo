/*
Modelo del producto para tratar la informacion que recibimos del endpoint 
*/
import 'dart:convert';

class ProductoModel {
    ProductoModel({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        this.create,
        required this.type
    });

  //Propiedades del objeto, solo una es opcional
    String id;
    String name;
    String description;
    String price;
    String? create;
    String type;

    //De un JSON retorna un mapa con las caracteristicas del JSON que recibe
    factory ProductoModel.fromJson(String str) => ProductoModel.fromMap(json.decode(str));

    //Codifica el objeto
    String toJson() => json.encode(toMap());

    //Retorna un objeto con las caracteristicas del mapa que recibe 

    factory ProductoModel.fromMap(Map<String, dynamic> json) => ProductoModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: (json["price"].toString()),
        create: json["create"] ?? '',
        type: json["type"] ?? ''
    );

    //Retorna un mapa con las caracteristicas del objeto

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "create": create ?? '',
        "type": type
    };

    //El metodo copy retorna una copia exacta del objeto que se puede modificar sin alterar al original

    ProductoModel copy() => ProductoModel(
      id: id,
      description: description,
      name: name,
      price: price,
      create: create,
      type: type
    );
}
