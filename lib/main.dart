// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:herpulse532/screens/auth/login_screen.dart';
import 'package:herpulse532/screens/auth/signup_screen.dart';
import 'package:herpulse532/screens/onboarding_screen.dart';
import 'package:herpulse532/screens/home_screen.dart';
import 'screens/cycle_tracker/cycle_tracking_page.dart';
import 'screens/cycle_tracker/period_symptoms_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/questionnaire_flow.dart';
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
        primaryColor: const Color(0xFF8A3FFC),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFFF5CA8),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/onboardingProfile': (_) => const QuestionnaireFlow(),
        '/home': (context) => const HomeScreen(),
        '/cycleTracker': (context) => const CycleTrackingPage(),
        '/periodSymptoms': (context) => const PeriodSymptomsScreen(),

      },// Starting page is SplashScreen
    );
  }
}
