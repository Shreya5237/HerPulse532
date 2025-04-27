// lib/screens/cycle_screen.dart

import 'package:flutter/material.dart';

class CycleScreen extends StatelessWidget {
  const CycleScreen({Key? key}) : super(key: key);

  final List<String> features = const [
    "AI-based cycle & ovulation predictions",
    "Monthly pain-level logging & trend analysis",
    "Sanitary product reminders",
    "Personalized diet & lifestyle tips",
    "Pain-reduction monitoring & medical advice"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menstrual Cycle Tracker"),
        backgroundColor: const Color(0xFF8A3FFC),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: features.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.check_circle, color: Color(0xFF8A3FFC)),
            title: Text(
              features[index],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            // you could add onTap → deep-dive into each feature
          );
        },
      ),
    );
  }
}
