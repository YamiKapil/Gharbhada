import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gharbhada/constants/error_handling.dart';
import 'package:gharbhada/constants/globalvariables.dart';
import 'package:gharbhada/constants/utils.dart';
import 'package:gharbhada/models/notification_model.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class NotificationServices {
  Future<List<NotificationModel>> fetchNotification({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<NotificationModel> notificaitonList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/notifications'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      log(res.body.toString());

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            notificaitonList.add(
              NotificationModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return notificaitonList;
  }

  Future<void> postNotification({
    required BuildContext context,
    required String description,
    required String userID,
    required String status,
    required List<String> images,
    required String latLong,
    required String location,
    required String message,
    required String name,
    required String price,
  }) async {
    try {
      NotificationModel order = NotificationModel(
        description: description,
        userId: userID,
        images: images,
        latLong: latLong,
        location: location,
        message: message,
        name: name,
        price: price,
      );
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('$uri/api/notifications'),
        body: order.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // showSnackBar(
          //   context,
          //   'Order placed successfully!',
          // );

          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   SignIn.routeName,
          //   (route) => false,
          // );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      debugPrint(e.toString());
    }
  }
}
