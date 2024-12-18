import 'dart:convert';

import 'package:amazone_clone/constants/global_variabl.dart';
import 'package:amazone_clone/constants/httperrorhandeling.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/models/product.dart';
import 'package:amazone_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SearchServices {
  Future<List<Product>> fetchSearchedProduct({
    required BuildContext context,
    required String query,
  }) async {
    // Fetch user token synchronously
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user.token;

    List<Product> productList = [];
    try {
      // Make the HTTP request asynchronously
      http.Response res = await http.get(
        Uri.parse('$uri/api/products/search/$query'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      httpErrorHandel(
        response: res,
        context: context,
        onSuccess: () {
          final List<dynamic> products = jsonDecode(res.body);
          for (var productData in products) {
            productList.add(
              Product.fromJson(jsonEncode(productData)),
            );
          }
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }

    return productList;
  }
}
