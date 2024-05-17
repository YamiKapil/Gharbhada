// import 'package:flutter/material.dart';

// TextField MyTextField(String label, hintText, bool obscureText) {
//   return TextField(
//     obscureText: obscureText,
//     decoration: InputDecoration(
//       label: Text(label),
//       hintText: hintText,
//       hintStyle: TextStyle(
//         color: Colors.grey,
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Colors.grey,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Colors.blue,
//         ),
//       ),
//     ),
//   );
// }


import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
