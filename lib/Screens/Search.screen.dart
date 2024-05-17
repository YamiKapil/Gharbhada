import 'package:flutter/material.dart';
import 'package:gharbhada/components/myTextField.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          // CustomTextField(controller: controller, hintText: hintText)
        ],
      ),
    ));
  }
}
