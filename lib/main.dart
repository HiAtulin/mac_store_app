import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/provider/user_provider.dart';
import 'package:mac_store_app/views/screens/authentication_screens/login_screen.dart';
import 'package:mac_store_app/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
    print('=== Starting Token Check ===');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print('SharedPreferences initialized');

    // 添加延迟确保数据已保存

    String? token = preferences.getString('auth_token');
    String? userJson = preferences.getString('user');
    if (token != null && userJson != null) {
      ref.read(userProvider.notifier).setUser(userJson);
    } else {
      ref.read(userProvider.notifier).clearUser();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder(
        future: _checkTokenAndSetUser(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final user = ref.watch(userProvider);
          return user != null ? MainScreen() : LoginScreen();
        },
      ),
    );
  }
}
