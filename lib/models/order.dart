import 'dart:convert';

import 'package:gharbhada/models/property.dart';

class Order {
  final String userID;
  String status = 'pending';
  final String? id;
  final List<Property>? property;

  Order({
    required this.userID,
    required this.status,
    this.id,
    this.property,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userID': userID,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      userID: map['userID'] ?? '',
      status: map['status'] ?? '',
      property: map['propertyID'] != null
          ? [Property.fromMap(map['propertyID'])]
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
