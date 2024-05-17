// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100.0,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: Image(image: AssetImage("assets/images/otp.png"))),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Enter your phone number"),
          ),
          IntlPhoneField(
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            initialCountryCode: 'NP',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
          ),
          Center(
            child: SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                child: Text("Get Code"),
                onPressed: () {
                  Navigator.pushNamed(context, '/otp');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(child: Text("We will send you a verification code"))
        ],
      ),
    );
  }
}
