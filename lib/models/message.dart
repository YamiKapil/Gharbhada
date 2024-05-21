import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String senderId;
  final String senderName;
  final String receiverId;
  final String receiverName;
  final Timestamp timestamp;

  Message({
    required this.message,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.receiverName,
    required this.timestamp,
  });

  // convert to map
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'timeStamp': timestamp,
    };
  }
}
