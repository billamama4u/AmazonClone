import 'dart:convert';

import 'package:amazone_clone/constants/global_variabl.dart';
import 'package:amazone_clone/constants/httperrorhandeling.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/models/order.dart';

import 'package:amazone_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderServices {
  Future<List<Order>> fetchOrders({
    required BuildContext context,
  }) async {
    List<Order> orderList = [];

    // Fetch user token synchronously
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user.token;

    try {
      // Make the HTTP request asynchronously
      http.Response res = await http.get(
        Uri.parse('$uri/api/orders'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      // Handle response
      httpErrorHandel(
        response: res,
        context: context,
        onSuccess: () {
          final List<dynamic> products = jsonDecode(res.body);
          for (var productData in products) {
            orderList.add(Order.fromJson(jsonEncode(productData)));
          }
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }

    return orderList;
  }
}
