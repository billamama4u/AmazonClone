import 'dart:convert';

import 'package:amazone_clone/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<String> images;
  final String? id;
  final List<Rating>? rating;

  Product(
    this.name,
    this.description,
    this.price,
    this.quantity,
    this.category,
    this.images,
    this.id,
    this.rating,
  );

  // Convert Product object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'images': images,
      'id': id,
      'rating': rating,
    };
  }

  // Create a Product instance from a Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      map['name'] ?? '',
      map['description'] ?? '',
      map['price']?.toDouble() ?? 0.0,
      map['quantity']?.toDouble() ?? 0.0,
      map['category'] ?? '',
      List<String>.from(map['images'] ?? []),
      map['_id'] ?? map['id'],
      map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  // Convert Product object to JSON
  String toJson() => json.encode(toMap());

  // Create a Product instance from JSON
  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
