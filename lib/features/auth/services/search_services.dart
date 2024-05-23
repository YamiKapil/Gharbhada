import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gharbhada/constants/error_handling.dart';
import 'package:gharbhada/constants/globalvariables.dart';
import 'package:gharbhada/constants/utils.dart';
import 'package:gharbhada/models/property.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SearchServices {
  Future<List<Property>> fetchSearchedProperty({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Property> propertyList = [];
    log(userProvider.user.token.toString());
    try {
      http.Response res = await http.get(
        // Uri.parse('$uri/api/property/search/$searchQuery'),
        Uri.parse('$uri/api/property/search?search=$searchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      log(res.toString());
      log(res.body.toString());
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body)['properties'].length; i++) {
            propertyList.add(
              Property.fromJson(
                jsonEncode(
                  jsonDecode(res.body)['properties'][i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return propertyList;
  }
}
