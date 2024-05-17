import 'package:flutter/material.dart';

class ProfileActionButton extends StatelessWidget {
  final String title;
  final Icon leadingIcon;
  final VoidCallback onTap;
  const ProfileActionButton({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(),
      onPressed: onTap,
      child: ListTile(
        title: Text(title),
        leading: leadingIcon,
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
