import 'package:flutter/material.dart';
import 'package:flutter_application_1/sign_up_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay 3 detik sebelum pindah ke LoginPage / SignUpPage
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignUpPage(),
          // langsung ke Sign Up
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo app
            Image.asset(
              "assets/icon/icon.png", // pastikan file ada di folder assets
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            // Nama aplikasi
            const Text(
              "MystiCat",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 136, 158),
                letterSpacing: 2,
              ),
            ),
            const Text(
              "By : Almas Rifda Zatadin",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 136, 158),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
