import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:mac_store_app/provider/user_provider.dart';
import 'package:mac_store_app/services/manage_http_response.dart';
import 'package:mac_store_app/views/screens/authentication_screens/login_screen.dart';
import 'package:mac_store_app/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );
      http.Response response = await http.post(
        Uri.parse('$url/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String token = jsonDecode(response.body)['token'];
          await preferences.setString('auth_token', token);
          final userJson = jsonEncode(jsonDecode(response.body)['user']);
          await preferences.setString('user', userJson);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          showSnackBar(context, "Account has been Created for you");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$url/api/signin"),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String token = jsonDecode(response.body)['token'];
          preferences.setString('auth_token', token);
          final userJson = jsonEncode(jsonDecode(response.body)['user']);
          ProviderContainer().read(userProvider.notifier).setUser(userJson);
          await preferences.setString('user', userJson);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
          );
          showSnackBar(context, "Logged In");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> signOutUsers({required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('auth_token');
      await preferences.remove('user');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
      showSnackBar(context, "Logged Out Successfully");
    } catch (e) {
      showSnackBar(context, "Error Logging Out");
      print("Error: $e");
    }
  }
}
