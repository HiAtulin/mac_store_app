import 'package:flutter/material.dart';
import 'package:mac_store_app/controllers/auth_controller.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await _authController.signOutUsers(context: context);
      },
      child: Text('Sign Out'),
    );
  }
}
