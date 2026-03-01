import 'package:flutter_riverpod/legacy.dart';
import 'package:mac_store_app/models/user.dart';

class UserProvider extends StateNotifier<User?> {
  UserProvider()
    : super(
        User(
          id: "",
          fullName: "",
          email: "",
          state: "",
          city: "",
          locality: '',
          password: '',
          token: '',
        ),
      );
  User? get user => state;
  void setUser(String userJson) => state = User.fromJson(userJson);
}

final userProvider = StateNotifierProvider<UserProvider, User?>(
  (ref) => UserProvider(),
);
