import 'dart:convert';

import 'package:gharbhada/Screens/Home.screen.dart';
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

class UserServices {
  void editprofile({
    required BuildContext context,
    required String email,
    required String name,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        showSnackBar(context, 'User not authenticated');
        return;
      }

      http.Response res = await http.patch(
        Uri.parse('$uri/edit-profile'),
        body: jsonEncode({
          'name': name,
          'email': email,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Provider.of<UserProvider>(context, listen: false)
              .user
              .copyWith(name: name);
          showSnackBar(context, 'Profile updated successfully');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get informationn of a single user by id
  Future<User> fetchUser({
    required BuildContext context,
    required String id,
  }) async {
    User user = User(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      token: '',
    );

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        showSnackBar(context, 'User not authenticated');
        return user;
      }

      http.Response res = await http.get(
        Uri.parse('$uri/user/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          user = User.fromJson(jsonDecode(res.body));
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return user;
  }
}
