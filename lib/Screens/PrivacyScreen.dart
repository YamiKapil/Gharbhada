import 'package:flutter/material.dart';

class PrivacySafetyPage extends StatelessWidget {
  static const String routeName = '/privacy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy and Safety'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              'We take your privacy seriously. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Safety Guidelines',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              'Your safety is our top priority. Here are some safety guidelines to ensure a secure experience:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            _buildSafetyListItem('Meet in public places',
                'Choose well-lit and crowded areas for meetings.'),
            _buildSafetyListItem('Share details cautiously',
                'Avoid sharing sensitive information such as your address or financial details.'),
            _buildSafetyListItem('Trust your instincts',
                'If something feels off, trust your gut instinct and consider ending the interaction.'),
            _buildSafetyListItem('Inform a friend or family member',
                'Let someone know where you are going and who you are meeting.'),
            _buildSafetyListItem('Report suspicious activity',
                'Report any suspicious behavior or activity to us.'),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyListItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
