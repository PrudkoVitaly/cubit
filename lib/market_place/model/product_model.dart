// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String category;
  String categoryImage;
  List<ProductElement> products;

  Product({
    required this.category,
    required this.categoryImage,
    required this.products,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        category: json["category"],
        categoryImage: json["category_image"],
        products: List<ProductElement>.from(
            json["products"].map((x) => ProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "category_image": categoryImage,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class ProductElement {
  bool like;
  String image;
  String title;
  int price;
  double rating;
  int quantity;
  Color bgColor;

  ProductElement({
    required this.like,
    required this.image,
    required this.title,
    required this.price,
    required this.rating,
    required this.quantity,
    this.bgColor = Colors.transparent,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        like: json["like"],
        image: json["image"],
        title: json["title"],
        price: (json["price"] as num).toInt(),
        rating: json["rating"]?.toDouble() ?? 0.0,
        quantity: (json["quantity"] as num).toInt(),
      );

  Map<String, dynamic> toJson() => {
        "like": like,
        "image": image,
        "title": title,
        "price": price,
        "rating": rating,
        "quantity": quantity,
      };
}
