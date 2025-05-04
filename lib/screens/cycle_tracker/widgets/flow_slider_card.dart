import 'package:flutter/material.dart';

/// Flow Intensity Slider Card
class FlowSliderCard extends StatefulWidget {
  const FlowSliderCard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FlowSliderCardState createState() => _FlowSliderCardState();
}

class _FlowSliderCardState extends State<FlowSliderCard> {
  double flowLevel = 3;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flow Intensity', style: Theme.of(context).textTheme.titleMedium),
            Slider(
              value: flowLevel,
              min: 0,
              max: 5,
              divisions: 5,
              label: flowLevel.round().toString(),
              onChanged: (val) => setState(() => flowLevel = val),
            ),
            Text(
              'Track light to heavy flow.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
