import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email, // Make sure email is included in the constructor
    required this.password,
    required this.address,
    required this.type,
    required this.token,
  });

  // Convert a User instance to a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email, // Include email in the map
      'password': password,
      'address': address,
      'type': type,
      'token': token,
    };
  }

  // Create a User instance from a Map.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '', // Include email in fromMap
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
