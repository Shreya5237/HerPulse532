// lib/screens/widgets/notification_card.dart

import 'package:flutter/material.dart';

/// Notification Card for upcoming period
class NotificationCard extends StatelessWidget {
  final int days;
  const NotificationCard({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF8A3FFC);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: primaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Your period is predicted in $days day${days > 1 ? 's' : ''}. Prepare accordingly!',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
