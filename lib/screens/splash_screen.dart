import 'package:basic_test/controllers/auth_controller.dart';
import 'package:basic_test/screens/login.dart';
import 'package:basic_test/screens/main_layout.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _goToNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Center(child: LinearProgressIndicator()),
      ),
    );
  }

  void _goToNextScreen() {
    Future.delayed(Duration(seconds: 2), () async {
      if (await AuthController().isLoggedIn()) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainLayout()),
          (_) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (_) => false,
        );
      }
    });
  }
}
