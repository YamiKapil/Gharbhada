import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gharbhada/constants/error_handling.dart';
import 'package:gharbhada/constants/globalvariables.dart';
import 'package:gharbhada/constants/utils.dart';
import 'package:gharbhada/models/order.dart';
import 'package:gharbhada/models/property.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderServices {
  void placeOrder({
    required BuildContext context,
    required String propertyID,
    required String userID,
    required String status,
  }) async {
    try {
      Order order = Order(
        id: '',
        userID: userID,
        status: status,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/order/$propertyID'),
        body: order.toJson(),
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
            'Order placed successfully!',
          );

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

  // get orders
  //

  Future<List<Order>> fetchOrder({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/orders/${userProvider.user.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(res.body);
        final List<Order> orders = [];

        for (var item in jsonData) {
          orders.add(Order.fromMap(item));
        }

        return orders;
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      throw Exception('Failed to fetch orders: $e');
    }
  }

  // fetch all orders for admin
  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // List<Order> orderList;

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-orders'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(res.body);
        final List<Order> orders = [];

        for (var item in jsonData) {
          orders.add(Order.fromMap(item));
        }

        return orders;
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      throw Exception('Failed to fetch orders: $e');
    }
  }

// update order status
  void updateOrderStatus({
    required BuildContext context,
    required String orderID,
    required String status,
  }) async {
    try {
      Order order = Order(
        id: orderID,
        status: status,
        userID: '',
      );

      http.Response res = await http.put(
        Uri.parse('$uri/admin/confirmOrreject'),
        body: order.toJson(),
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
            'Order status updated successfully!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      debugPrint(e.toString());
    }
  }
}
