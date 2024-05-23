import 'dart:convert';

class Property {
  final String name;
  final String location;
  final String description;
  final String price;
  final String latLong;
  final List<String> images;
  bool isBought;
  final String? id;

  Property({
    required this.name,
    required this.location,
    required this.description,
    required this.price,
    required this.latLong,
    required this.images,
    this.isBought = false,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'latlong': latLong,
      'price': price,
      'images': images,
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      latLong: map['latlong'] ?? '',
      price: map['price'] ?? '',
      images: List<String>.from(map['images'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Property.fromJson(String source) =>
      Property.fromMap(json.decode(source));
}
