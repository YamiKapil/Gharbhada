import 'package:flutter/material.dart';
import 'package:gharbhada/components/myTextField.dart';
import 'package:gharbhada/features/auth/services/recommend_service.dart';

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({super.key});

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController aana = TextEditingController();
  final TextEditingController road = TextEditingController();
  final TextEditingController price = TextEditingController();
  final RecommendServices recommendServices = RecommendServices();

  void recommendProperty() {
    recommendServices.fetchRecommendProperty(
      context: context,
      aana: aana.text,
      road: road.text,
      price: price.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommend Property'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Text("Aana"),
            SizedBox(height: 10.0),
            CustomTextField(
              controller: aana,
              hintText: 'Aana',
            ),
            const SizedBox(height: 20),
            Text("Road"),
            SizedBox(height: 10.0),
            CustomTextField(
              controller: road,
              hintText: 'Road',
            ),
            const SizedBox(height: 20),
            Text("Price"),
            SizedBox(height: 10.0),
            CustomTextField(
              controller: road,
              hintText: 'Price',
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 40, 88, 192),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    recommendProperty();
                  }
                },
                child: Text("    Recommend Property    ",
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
