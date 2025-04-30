import 'package:flutter/material.dart';
import 'package:herpulse532/screens/auth/login_screen.dart';
import '../models/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> contents = [
    OnboardingContent(
      title: "Caring for Every Phase",
      image: "assets/images/phase.png", description: '',
    ),
    OnboardingContent(
      title: "Track Hormonal Changes",
      image: "assets/images/hormone.png", description: '',
    ),
    OnboardingContent(
      title: "Prioritizing Safety",
      image: "assets/images/safety.png", description: '',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFEDE7F6), Color(0xFFF3E5F5)],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top bar with Skip
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (_currentPage < contents.length - 1)
                        TextButton(
                          onPressed: () => _goToLastPage(),
                          child: const Text(
                            'Skip',
                            style: TextStyle(color: Color(0xFF8A3FFC), fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: contents.length,
                    onPageChanged: (idx) => setState(() => _currentPage = idx),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, idx) {
                      final item = contents[idx];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Parallax image
                          Expanded(
                            flex: 6,
                            child: AnimatedBuilder(
                              animation: _pageController,
                              builder: (context, child) {
                                double value = 1;
                                if (_pageController.position.haveDimensions) {
                                  value = _pageController.page! - idx;
                                  value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                                }
                                return Transform.scale(
                                  scale: Curves.easeOut.transform(value),
                                  child: child,
                                );
                              },
                              child: Image.asset(
                                item.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Title
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2B0A3D),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Indicators
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(contents.length, (i) => _dot(i)),
                          ),
                          const SizedBox(height: 32),
                        ],
                      );
                    },
                  ),
                ),
                // Navigation buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Opacity(
                        opacity: _currentPage > 0 ? 1 : 0,
                        child: TextButton(
                          onPressed: _currentPage > 0 ? () => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut) : null,
                          child: const Text('Previous', style: TextStyle(color: Color(0xFF8A3FFC), fontSize: 16)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_currentPage == contents.length - 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                            );
                          } else {
                            _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          backgroundColor: const Color(0xFF8A3FFC),
                          elevation: 6,
                        ),
                        child: Text(
                          _currentPage == contents.length - 1 ? 'Get Started' : 'Next',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(int i) {
    bool active = i == _currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF8A3FFC) : Colors.white54,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _goToLastPage() {
    _pageController.animateToPage(contents.length - 1,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }
}
