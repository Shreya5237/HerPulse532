// lib/screens/widgets/monitoring_card.dart

import 'package:flutter/material.dart';

/// Gradual Pain Monitoring Card
class MonitoringCard extends StatelessWidget {
  const MonitoringCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Brand primary color
    const primaryColor = Color(0xFF8A3FFC);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pain Trend Monitoring',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'If pain doesn\'t improve over cycles, consult a physician.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to consult screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('Consult a Physician'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
