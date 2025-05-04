import 'package:flutter/material.dart';
/// Pain Level Slider Card
class PainSliderCard extends StatefulWidget {
  const PainSliderCard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PainSliderCardState createState() => _PainSliderCardState();
}

class _PainSliderCardState extends State<PainSliderCard> {
  double painLevel = 5;
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
            Text('Pain Level', style: Theme.of(context).textTheme.titleMedium),
            Slider(
              value: painLevel,
              min: 0,
              max: 10,
              divisions: 10,
              label: painLevel.round().toString(),
              onChanged: (val) => setState(() => painLevel = val),
            ),
            Text(
              'Nutrient Tip: Increase iron-rich foods if pain is high.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
