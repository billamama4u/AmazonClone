// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazone_clone/common/widgets/bottombar.dart';
import 'package:amazone_clone/constants/global_variabl.dart';
import 'package:amazone_clone/constants/httperrorhandeling.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/models/user.dart';
import 'package:amazone_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpuser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(
                context, 'Account  cereated!Login with same credentials');
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  //signIn
  void signinuser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // Perform the HTTP POST request
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Handle HTTP response
      httpErrorHandel(
        response: res,
        context: context,
        onSuccess: () async {
          // Obtain shared preferences instance
          SharedPreferences pref = await SharedPreferences.getInstance();

          // Store the authentication token
          await pref.setString('x-auth-token', jsonDecode(res.body)['token']);

          // Update the user provider with the user data
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          // Navigate to the home screen
          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          }
        },
      );
    } catch (e) {
      // Show an error message
      if (context.mounted) {
        showSnackbar(context, e.toString());
      }
    }
  }

  //get user data

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');

      if (token == null) {
        pref.setString('x-auth-token', '');
      }
      http.Response tokenResponse = await http
          .post(Uri.parse('$uri/tokenisvalid'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!
      });

      var response = jsonDecode(tokenResponse.body);

      if (response == true) {
        http.Response user = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(user.body);
      }
    } catch (e) {
      // Show an error message
      if (context.mounted) {
        showSnackbar(context, e.toString());
      }
    }
  }
}
