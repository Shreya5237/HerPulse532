import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';
import 'onboarding_screen.dart'; // 👈 Import your onboarding screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White Background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Heart Shape Placeholder
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF8A3FFC), // Purple
                    Color(0xFFFF5CA8), // Pink
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.favorite, // Temporary Heart Icon
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // App Name
            Text(
              'HerPulse',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D0A50), // Dark Violet
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            // Tagline Animation
            AnimatedTextKit(
              animatedTexts: [
                FadeAnimatedText(
                  'Empowering Every Heartbeat',
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  duration: const Duration(milliseconds: 2000),
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ],
        ),
      ),
    );
  }
}
