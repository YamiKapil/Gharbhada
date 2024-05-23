import 'package:flutter/material.dart';
import 'package:gharbhada/features/auth/services/auth_service.dart';
import 'package:gharbhada/components/myTextField.dart';
import 'package:gharbhada/constants/globalvariables.dart';
import 'package:gharbhada/features/auth/services/user_service.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = '/edit-profile';
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _editFormKey = GlobalKey<FormState>();
  final UserServices userServices = UserServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
  }

  void editProfile() {
    userServices.editprofile(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Edit Your Profile",
                style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: GlobalVariables.backgroundColor,
              child: Form(
                key: _editFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Name',
                    ),
                    const SizedBox(height: 10),
                    // CustomTextField(
                    //   controller: _emailController,
                    //   hintText: 'Email',
                    // ),
                    // const SizedBox(height: 10),
                    SizedBox(
                      height: 45,
                      width: 300.0,
                      child: ElevatedButton(
                        child: Text("Update Account"),
                        onPressed: () {
                          if (_editFormKey.currentState!.validate()) {
                            editProfile();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
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
