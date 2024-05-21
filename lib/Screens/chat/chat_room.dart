import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbhada/Screens/chat/chat_screen.dart';
import 'package:gharbhada/models/user.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserProvider>(context, listen: true).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Room'),
      ),
      body: _buildUserList(userInfo),
    );
  }

// build user list
  Widget _buildUserList(User userInfo) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error fetching data');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildUserListItem(doc, userInfo))
                .toList(),
          );
        });
  }

  // build user list item
  Widget _buildUserListItem(DocumentSnapshot snapshot, User userInfo) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    if (userInfo.id != data['id']) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          tileColor: Colors.white,
          title: Text(data['name']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChatScreen(
                    receiverId: data['id'],
                    receiverName: data['name'],
                  );
                },
              ),
            );
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
