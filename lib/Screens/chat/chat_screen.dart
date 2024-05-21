import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbhada/Screens/chat/chat_bubble.dart';
import 'package:gharbhada/components/myTextField.dart';
import 'package:gharbhada/features/auth/services/chat_service.dart';
import 'package:gharbhada/models/user.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String? receiverId;
  final String? receiverName;
  const ChatScreen({
    super.key,
    this.receiverId,
    this.receiverName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService chatService = ChatService();

  void sendMessage(BuildContext context) async {
    final userInfo = Provider.of<UserProvider>(context, listen: false).user;
    if (_messageController.text.isNotEmpty) {
      await chatService.sendMessage(
        message: _messageController.text,
        receiverId: widget.receiverId ?? '',
        receiverName: widget.receiverName ?? '',
        senderId: userInfo.id,
        senderName: userInfo.name,
      );
      // clear the controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserProvider>(context, listen: true).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat With Each Other'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: _buildMessageList(userInfo),
            ),
            // user input
            _buildMessageInput(context),
          ],
        ),
      ),
    );
  }

  // build message list
  Widget _buildMessageList(User userInfo) {
    return StreamBuilder(
      stream: chatService.getMessages(widget.receiverId ?? '', userInfo.id),
      builder: (context, snapshot) {
        log(snapshot.data?.docs.toString() ?? 'nn', name: 'doc');
        if (snapshot.hasError) {
          return const Text('Error fetching data');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          reverse: true,
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document, userInfo))
              .toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot document, User userInfo) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    log(data.toString());
    // align the messages to the right if the sender is the current user, otherwise to the left
    var alignment = (data['senderId'] == userInfo.id)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Text(
            data['senderName'],
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 2),
          ChatBubble(
            message: data['message'],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // build message input
  Widget _buildMessageInput(context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: _messageController,
            hintText: 'Enter a message',
          ),
        ),
        // send button
        IconButton(
          onPressed: () {
            sendMessage(context);
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
