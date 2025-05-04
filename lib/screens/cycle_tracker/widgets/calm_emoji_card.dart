import 'package:flutter/material.dart';
/// Calm Emoji Card when no notification
class CalmEmojiCard extends StatelessWidget {
  const CalmEmojiCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('😊', style: TextStyle(fontSize: 48)));
  }
}
