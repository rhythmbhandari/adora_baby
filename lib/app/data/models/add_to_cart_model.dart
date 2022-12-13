// To parse this JSON data, do
//
//     final addToCart = addToCartFromJson(jsonString);

import 'dart:convert';

AddToCart addToCartFromJson(String str) => AddToCart.fromJson(json.decode(str));

String addToCartToJson(AddToCart data) => json.encode(data.toJson());

class AddToCart {
  AddToCart({
    required this.product,
    required this.quantity,
  });

  String product;
  int quantity;

  factory AddToCart.fromJson(Map<String, dynamic> json) => AddToCart(
    product: json["product"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "product": product,
    "quantity": quantity,
  };
}
