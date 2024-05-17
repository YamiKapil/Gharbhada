import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final index;
  final title;
  final subtitle;
  final VoidCallback? onConfirm;
  final VoidCallback? onDelete;
  const OrderTile(
      {super.key,
      required this.index,
      this.subtitle,
      this.title,
      this.onConfirm,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.done,
              ),
              onPressed: onConfirm,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
