import 'package:flutter/material.dart';
import 'package:herpulse532/screens/auth/login_screen.dart';
import 'package:herpulse532/screens/auth/signup_screen.dart';
import 'package:herpulse532/screens/onboarding_screen.dart';
import 'package:herpulse532/screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/user_profile_onboarding.dart';
import 'screens/welcome_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove Debug Banner
      title: 'HerPulse',
      theme: ThemeData(
        fontFamily: 'Roboto', // Set font globally if you want
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xFF8A3FFC),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFFF5CA8),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/onboardingProfile': (_) => UserProfileOnboarding(),
        '/home': (context) => const HomeScreen(),

      },// Starting page is SplashScreen
    );
  }
}
