import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbhada/models/message.dart';
import 'package:provider/provider.dart';

class ChatService extends ChangeNotifier {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // send message
  Future<void> sendMessage({
    required String message,
    required String receiverId,
    required String receiverName,
    required String senderId,
    required String senderName,
  }) async {
    // get current user info
    final Timestamp timestamp = Timestamp.now();
    // create a new message
    Message newMessage = Message(
      message: message,
      senderId: senderId,
      senderName: senderName,
      receiverId: receiverId,
      receiverName: receiverName,
      timestamp: timestamp,
    );

    // construct chat room id from current user id and receiver id(sorted to ensure uniqueness)
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // add new message to datatbase
    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .snapshots();
  }
}
