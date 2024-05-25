import 'dart:convert';

class NotificationModel {
  final String name;
  final String userId;
  final String location;
  final String description;
  final String price;
  final String latLong;
  final List<String> images;
  final String? message;

  NotificationModel({
    required this.name,
    required this.location,
    required this.description,
    required this.price,
    required this.latLong,
    required this.images,
    required this.message,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'message': message,
      'name': name,
      'location': location,
      'description': description,
      'latlong': latLong,
      'price': price,
      'images': images,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      latLong: map['latlong'] ?? '',
      price: map['price'] ?? '',
      message: map['message'] ?? '',
      images: List<String>.from(map['images'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));
}
