import 'package:flutter/material.dart';
import 'package:gharbhada/models/user.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserPersonalDetailsPage extends StatelessWidget {
  static const String routeName = '/user-details';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Id', user.id),

            _buildDetailRow('Name', user.name),
            _buildDetailRow('Email', user.email),
            // _buildDetailRow('Address', user.address),
            _buildDetailRow('User Type', user.type),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
