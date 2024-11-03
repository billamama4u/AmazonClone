import 'dart:convert';

import 'package:amazone_clone/models/product.dart';

class Order {
  final String id;
  final String userId;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final int orderedAt;
  final int status;
  final double totalPrice;

  Order(this.id, this.userId, this.products, this.quantity, this.address,
      this.orderedAt, this.status, this.totalPrice);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userId': userId});
    result.addAll({'products': products.map((x) => x.toMap()).toList()});
    result.addAll({'quantity': quantity});
    result.addAll({'address': address});
    result.addAll({'orderedAt': orderedAt});
    result.addAll({'status': status});
    result.addAll({'totalPrice': totalPrice});

    return result;
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      map['id'] ?? '',
      map['userId'] ?? '',
      List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x['product']))),
      List<int>.from(map['quantity']?.map((x) => x['quantity'])),
      map['address'] ?? '',
      map['orderedAt']?.toInt() ?? 0,
      map['status']?.toInt() ?? 0,
      map['totalPrice']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
