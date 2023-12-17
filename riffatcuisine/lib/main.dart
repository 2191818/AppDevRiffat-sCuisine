import 'package:flutter/material.dart';
import 'database.dart';
import 'splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the user database
  var userDatabase = UserDatabase();
  await userDatabase.open();

  // Create non-admin user
  Map<String, dynamic> user1 = {
    'username': 'user1',
    'password': 'password1',
    'email': 'user1@example.com',
    'first_name': 'John',
    'last_name': 'Doe',
    'is_admin': 0,
  };

  await userDatabase.createUser(user1);

  // Create admin user
  Map<String, dynamic> user2 = {
    'username': 'user2',
    'password': 'password2',
    'email': 'user2@example.com',
    'first_name': 'Admin',
    'last_name': 'User',
    'is_admin': 1,
  };

  await userDatabase.createUser(user2);

  // Run the app
  runApp(const MyApp());
}

Color customColorFireBrick = const Color(0xFFB22222);
Color customColorOldLace = const Color(0xFFfdf5e6);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
