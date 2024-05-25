import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gharbhada/Screens/search_screen.dart';
import 'package:gharbhada/constants/error_handling.dart';
import 'package:gharbhada/constants/globalvariables.dart';
import 'package:gharbhada/constants/utils.dart';
import 'package:http/http.dart' as http;

class RecommendServices {
  Future<void> fetchRecommendProperty({
    required BuildContext context,
    required String aana,
    required String road,
    required String price,
  }) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // log(userProvider.user.token.toString());
    try {
      http.Response res = await http.post(Uri.parse('$pythonuri'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        // 'x-auth-token': userProvider.user.token,
      }, body: {
        'Aana': aana,
        'Road': road,
        'Price': price,
      });

      log(res.toString());
      log(res.body.toString());
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final searchtext = jsonDecode(res.body)?['Recommended Place'] ?? '';
          Navigator.pushNamed(
            context,
            SearchScreen.routeName,
            arguments: searchtext,
          );
          // SearchServices().fetchSearchedProperty(
          //     context: context,
          //     searchQuery: jsonDecode(res.body)?['Recommended Place'] ?? '');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
