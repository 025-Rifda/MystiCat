import 'package:flutter/material.dart';
import 'package:flutter_application_1/sign_up_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();

    // Efek fade-in dan scale-up
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1;
        _scale = 1;
      });
    });

    // Setelah 3 detik, fade-out dan navigasi ke SignUpPage
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;

      setState(() => _opacity = 0);
      await Future.delayed(const Duration(milliseconds: 600));

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignUpPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutBack,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🌟 Hero logo MystiCat
                Hero(
                  tag: 'logoMystiCat',
                  child: Image.asset(
                    "assets/icon/icon.png",
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20),

                // 🩷 Hero text
                const Hero(
                  tag: 'titleMystiCat',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "MystiCat",
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 251, 112, 112),
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: Color.fromARGB(90, 255, 136, 158),
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Text(
                  "By: Almas Rifda Zatadin",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 251, 112, 112),
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 50),

                // 🐾 Cute loading animation (built-in)
                LoadingAnimationWidget.bouncingBall(
                  color: Color.fromARGB(255, 251, 112, 112),
                  size: 60,
                ),

                const SizedBox(height: 15),
                const Text(
                  "Preparing your meow-verse...",
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
