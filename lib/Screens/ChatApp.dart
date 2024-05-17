import 'package:flutter/material.dart';
import 'package:gharbhada/models/user.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // List to hold chat messages
  List<Map<String, dynamic>> messages = [];
  //fetch from user provider

  // TextEditingController for the message input field
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch initial messages from the backend
    fetchMessages();
  }

  // Function to fetch messages from the backend server
  Future<void> fetchMessages() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:5123/messages'));
      if (response.statusCode == 200) {
        // Parse the JSON response and update the list of messages
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          messages = data.cast<Map<String, dynamic>>();
        });
      } else {
        // Handle error
        print('Failed to fetch messages: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  // Function to send a new message to the backend server
  Future<void> sendMessage() async {
    final newMessage = {
      'text': _messageController.text,
      // Adding current timestamp to the new message
      'timestamp': DateTime.now().toIso8601String(),
    };

    try {
      // Send the new message to the backend server
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5123/messages'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(newMessage),
      );

      if (response.statusCode == 201) {
        // If the message was successfully sent, add it to the list of messages
        setState(() {
          messages.add(newMessage);
        });
        // Clear the input field
        _messageController.clear();
      } else {
        // Handle error
        print('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat With Each Other')),
      body: Column(
        children: [
          // Display messages in a ListView
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message['sender'] == 'You';
                // Format the timestamp
                final timestamp = DateFormat('dd/MM/yyyy hh:mm a')
                    .format(DateTime.parse(message['timestamp']));

                return ListTile(
                  title: Container(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: isUserMessage
                            ? Colors.blueAccent.withOpacity(0.7)
                            : Color.fromARGB(255, 28, 26, 26).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   message['sender'],
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          Text(
                            message['text'],
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            timestamp,
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // subtitle:
                  //     isUserMessage ? null : Text('From: ${message['sender']}'),
                );
              },
            ),
          ),
          // Input field and send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}