// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gharbhada/Screens/AdminSignIn.dart';
import 'package:gharbhada/Screens/SignUp.screen.dart';
import 'package:gharbhada/components/myTextField.dart';
import 'package:gharbhada/features/auth/services/auth_service.dart';
import 'package:gharbhada/constants/globalvariables.dart';

class SignIn extends StatefulWidget {
  static const String routeName = '/signin-screen';
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _signInFormKey = GlobalKey<FormState>();
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
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
                            color: Colors.black,
                            fontSize: 20.0,
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
                      "Sign In",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email address"),
                      SizedBox(height: 10.0),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 20),
                      Text("Password"),
                      SizedBox(height: 10.0),
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
                    if (_signInFormKey.currentState!.validate()) {
                      signInUser();
                    }
                  },
                  child: Text("            Log In            ",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
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
              // Center(
              //   child: RichText(
              //     text: TextSpan(
              //       text: "Go to Admin ",
              //       style: TextStyle(
              //         color: Colors.black,
              //       ),
              //       children: [
              //         TextSpan(
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () {
              //               Navigator.pushNamedAndRemoveUntil(
              //                 context,
              //                 AdminSignIn.routeName,
              //                 (route) => false,
              //               );
              //             },
              //           text: "Login",
              //           style: TextStyle(
              //             color: Color.fromARGB(255, 40, 88, 192),
              //             decoration: TextDecoration.underline,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
