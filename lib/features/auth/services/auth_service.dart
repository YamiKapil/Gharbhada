// import 'package:amazon_clone_tutorial/common/widgets/bottom_bar.dart';
import 'dart:convert';

import 'package:gharbhada/Screens/Admin.screen.dart';
import 'package:gharbhada/Screens/SignIn.screen.dart';
import 'package:gharbhada/constants/error_handling.dart';
import 'package:gharbhada/constants/globalvariables.dart';
import 'package:gharbhada/constants/utils.dart';
import 'package:gharbhada/main.dart';
import 'package:gharbhada/models/user.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );

          Navigator.pushNamedAndRemoveUntil(
            context,
            SignIn.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      debugPrint(e.toString());
    }
  }

  //singnnin

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          dynamic userData = jsonDecode(res.body);
          String userType = userData['type'];
          print(
              'User Type: $userType, Token: ${userData['token']}, User: ${userData['user']}');

          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', userData['token']);

          if (userType == 'admin') {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AdminScreen.routeName,
              (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Gharbhada.routeName,
              (route) => false,
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void AdminsignInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            AdminScreen.routeName,
            (route) => false,
            //show ad
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
