import 'package:flutter/material.dart';

Column MyProfileCard(String title, String image, String subtitle) {
  return Column(
    children: [
      Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Image(
          image: AssetImage(image),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      ListTile(
        title: Center(child: Text(title)),
        subtitle: Center(child: Text(subtitle)),
      ),
    ],
  );
}
