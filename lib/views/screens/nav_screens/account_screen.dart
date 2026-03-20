import 'package:flutter/material.dart';
import 'package:mac_store_app/controllers/auth_controller.dart';
import 'package:mac_store_app/views/screens/detail/screens/order_screen.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // await _authController.signOutUsers(context: context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderScreen()),
        );
      },
      child: Text('My Orders'),
    );
  }
}
