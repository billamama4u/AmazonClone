// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazone_clone/constants/global_variabl.dart';
import 'package:amazone_clone/constants/httperrorhandeling.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/features/auth/authscreens/authscreen.dart';
import 'package:amazone_clone/models/product.dart';
import 'package:amazone_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homeservices {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/get-products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }

    return productList;
  }

  Future<Product> fetchDOTDProduct({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product('', '', 0, 0, '', [], '', null);
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            product = Product.fromJson(res.body);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }

    return product;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        Authscreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
