// lib/screens/cycle_tracking_page.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'period_symptoms_screen.dart';
import 'widgets/enhanced_cycle_chart.dart';
import 'widgets/notification_card.dart';
import 'widgets/calm_emoji_card.dart';
import 'widgets/action_button.dart';
import 'widgets/pain_slider_card.dart';
import 'widgets/flow_slider_card.dart';
import 'widgets/symptom_tags.dart';
import 'widgets/monitoring_card.dart';

class CycleTrackingPage extends StatelessWidget {
  const CycleTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample cycle data: days 1-5 = period (y=1), rest = non-period (y=0)
    final dataSpots = List.generate(
      28,
      (i) => FlSpot((i + 1).toDouble(), i < 5 ? 1 : 0),
    );

    // AI prediction: days until period starts
    const int daysUntilPeriod = 2;
    const bool showNotification = daysUntilPeriod <= 3;
    const bool inPredictedPeriod =
        daysUntilPeriod <= 0 || daysUntilPeriod > 28; // adjust as needed

    // Your brand colors
    const Color primaryColor = Color(0xFF8A3FFC);
    const Color secondaryColor = Color(0xFFFF5CA8);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cycle & Alerts'),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Enhanced Cycle Prediction Chart
              EnhancedCycleChart(dataSpots: dataSpots),
              const SizedBox(height: 24),

              // 2. Notification or calm emoji
              if (showNotification)
                const NotificationCard(days: daysUntilPeriod)
              else
                const CalmEmojiCard(),
              const SizedBox(height: 24),

              // 3. Manual entry buttons
              Row(
                children: [
                  Expanded(
                    child: ActionButton(
                      icon: Icons.warning,
                      label: 'Ohh... it came!',
                      color: primaryColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PeriodSymptomsScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ActionButton(
                      icon: Icons.sentiment_satisfied,
                      label: 'Nahh, not yet',
                      color: secondaryColor,
                      onTap: () {
                        // mark no start
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 4. Pain and Flow sliders
              const Row(
                children: [
                  Expanded(child: PainSliderCard()),
                  SizedBox(width: 16),
                  Expanded(child: FlowSliderCard()),
                ],
              ),
              const SizedBox(height: 32),

              // 5. Symptom Tags only during period
              if (inPredictedPeriod) ...[
                Text(
                  'Track Additional Symptoms',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const SymptomTags(),
                const SizedBox(height: 32),
              ],

              // 6. Gradual Pain Monitoring & CTA
              const MonitoringCard(),
            ],
          ),
        ),
      ),
    );
  }
}
