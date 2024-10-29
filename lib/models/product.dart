import 'dart:convert';

class Product {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<String> images;
  final String? id;

  Product(
    this.name,
    this.description,
    this.price,
    this.quantity,
    this.category,
    this.images,
    this.id,
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
    );
  }

  // Convert Product object to JSON
  String toJson() => json.encode(toMap());

  // Create a Product instance from JSON
  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
