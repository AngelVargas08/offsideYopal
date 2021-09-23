// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
    Product({
       required this.available,
         this.idAdmin,
       required this.name,
        this.picture,
       required this.price,
        this.id,
    });

    bool available;
    String? idAdmin;
    String name;
    String? picture;
    double price;
     String? id;

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        idAdmin: json["idAdmin"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "available": available,
        "idAdmin": idAdmin,
        "name": name,
        "picture": picture,
        "price": price,
    };

Product copy() => Product(
      available : this.available,
      name : this.name,
      picture : this. picture,
      price : this.price,
       id : this. id, 
       idAdmin: this.idAdmin,
    );

}
