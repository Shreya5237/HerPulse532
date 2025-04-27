import 'package:flutter/material.dart';

class InsightsTab extends StatelessWidget {
  const InsightsTab({Key? key}) : super(key: key);

  final List<Map<String, String>> _insights = const [
    {
      "title": "Stay Hydrated 💧",
      "description": "Drink at least 8 glasses of water daily to keep your body energized."
    },
    {
      "title": "Daily Walk 🚶‍♀️",
      "description": "A 30-minute walk improves cardiovascular health and boosts mood."
    },
    {
      "title": "Emergency Tips 🆘",
      "description": "Always share your live location with trusted contacts when traveling alone."
    },
    {
      "title": "Positive Mindset 🌈",
      "description": "Start each day with an affirmation: 'I am strong, I am safe, I am loved.'"
    },
    {
      "title": "Self Defense 🥋",
      "description": "Learn basic self-defense moves to increase your confidence outdoors."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _insights.length,
      itemBuilder: (context, index) {
        final insight = _insights[index];
        return _buildInsightCard(insight["title"]!, insight["description"]!);
      },
    );
  }

  Widget _buildInsightCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8A3FFC),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF2B0A3D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
