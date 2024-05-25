import 'package:flutter/material.dart';

// String uri = 'http://192.168.10.108:5123';

// String uri = 'http://10.0.2.2:5123';
String uri = 'http://localhost:5123';
String pythonuri = 'http://127.0.0.1:8000/predict';

// notification
String notificaiton = '/api/notifications';

// String uri = 'http://192.168.1.73:5123';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromARGB(255, 15, 119, 204);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
}
