import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gharbhada/constants/error_handling.dart';
import 'package:gharbhada/constants/globalvariables.dart';
import 'package:gharbhada/constants/utils.dart';
import 'package:gharbhada/models/property.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PropertyDetailsServices {
  // get a single Property details from id
  Future<Property> fetchProperty({
    required BuildContext context,
    required String id,
  }) async {
    Property property = Property(
      id: '',
      name: '',
      location: '',
      price: '',
      description: '',
      latLong: '',
      images: [],
    );

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse('$uri/api/property/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          property = Property.fromJson(jsonDecode(res.body));
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return property;
  }
}
