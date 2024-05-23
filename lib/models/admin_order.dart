import 'dart:convert';

import 'package:gharbhada/models/property.dart';

class AdminOrder {
  final String userID;
  String status = 'pending';
  final String? id;
  final Property? property;

  AdminOrder({
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

  factory AdminOrder.fromMap(Map<String, dynamic> map) {
    return AdminOrder(
      id: map['_id'] ?? '',
      userID: map['userID'] ?? '',
      status: map['status'] ?? '',
      property: map['propertyID'] != null
          ? Property.fromMap(map['propertyID'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminOrder.fromJson(String source) =>
      AdminOrder.fromMap(json.decode(source));
}
