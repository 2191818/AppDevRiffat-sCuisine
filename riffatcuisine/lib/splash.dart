import 'dart:async';
import 'package:flutter/material.dart';
import 'login.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColorOldLace,
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ]
          ),
          child: Center(
            child: Image.asset('assets/images/tablogo.png'),
          ),
        ),
      ),
    );
  }
}
