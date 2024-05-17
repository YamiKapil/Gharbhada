// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gharbhada/Screens/AdminSignIn.dart';
import 'package:gharbhada/Screens/SignUp.screen.dart';
import 'package:gharbhada/components/myTextField.dart';
import 'package:gharbhada/features/auth/services/auth_service.dart';
import 'package:gharbhada/constants/globalvariables.dart';

class AdminSignIn extends StatefulWidget {
  static const String routeName = '/admin-signin-screen';
  const AdminSignIn({super.key});

  @override
  State<AdminSignIn> createState() => _SignInState();
}

class _SignInState extends State<AdminSignIn> {
  // final _adminsignInFormKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100.0, left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Ghar Bhada",
                      style: TextStyle(
                        color: Color.fromARGB(255, 102, 180, 223),
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Admin Sign In",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: GlobalVariables.backgroundColor,
            child: Form(
              // key: _adminsignInFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     InkWell(
          //       onTap: () {},
          //       child: Text("Forgot Password?"),
          //     ),
          //     SizedBox(
          //       width: 10.0,
          //     )
          //   ],
          // ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 40, 88, 192),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                signInUser();
              },
              child: Text("Sign In"),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          SignUp.routeName,
                          (route) => false,
                        );
                      },
                    text: "Sign Up",
                    style: TextStyle(
                      color: Color.fromARGB(255, 40, 88, 192),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                text: "Go to Admin ",
                style: TextStyle(
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AdminSignIn.routeName,
                          (route) => false,
                        );
                      },
                    text: "Login",
                    style: TextStyle(
                      color: Color.fromARGB(255, 40, 88, 192),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
