import 'package:flutter/material.dart';
import 'package:gharbhada/features/auth/services/auth_service.dart';
import 'package:gharbhada/components/myTextField.dart';
import 'package:gharbhada/constants/globalvariables.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/signup-screen';
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signUpFormKey = GlobalKey<FormState>();
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

  void signUpUser() {
    authService.signUpUser(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100.0,
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
            const Center(
              child: Text(
                "Congratulations",
                style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "on verifying your phone number",
              style: TextStyle(
                color: Color.fromARGB(255, 3, 39, 92),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Text(
              "We need more information from you",
              style: TextStyle(
                color: Color.fromARGB(255, 3, 39, 92),
                fontSize: 12.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: GlobalVariables.backgroundColor,
              child: Form(
                key: _signUpFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Create a username',
                    ),
                    const SizedBox(height: 10),
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
                    SizedBox(
                      height: 45,
                      width: 300.0,
                      child: ElevatedButton(
                        child: const Text("Activate Account"),
                        onPressed: () {
                          if (_signUpFormKey.currentState!.validate()) {
                            signUpUser();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 8, 94, 165),
                            foregroundColor: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
