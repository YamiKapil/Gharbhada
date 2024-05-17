import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gharbhada/constants/error_handling.dart';
import 'package:gharbhada/constants/globalvariables.dart';
import 'package:gharbhada/constants/utils.dart';
import 'package:gharbhada/models/property.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProperty({
    required BuildContext context,
    required String name,
    required String location,
    required String price,
    required String description,
    required String latLong,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic("dzfvvibez", "zpr3ydry");
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Property property = Property(
        name: name,
        location: location,
        description: description,
        price: price,
        images: imageUrls,
        latLong: latLong,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-property'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: property.toJson(),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Property Added Succefully');
            // Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      debugPrint(e.toString());
    }
  }

  // get all products

  Future<List<Property>> fetchAllProperties(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Property> propertyList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-properties'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              propertyList.add(
                Property.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return propertyList;
  }

  // delete property
  void deleteProperty(
      {required context,
      required Property property,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-property'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': property.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
