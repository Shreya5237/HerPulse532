// lib/screens/widgets/symptom_tags.dart

import 'package:flutter/material.dart';

/// Symptom Tags
class SymptomTags extends StatefulWidget {
  const SymptomTags({super.key});

  @override
  _SymptomTagsState createState() => _SymptomTagsState();
}

class _SymptomTagsState extends State<SymptomTags> {
  final List<String> symptoms = [
    'Bloating',
    'Tenderness',
    'Fatigue',
    'Headache',
    'Cramping',
  ];
  final Set<String> selected = {};
  static const Color primaryColor = Color(0xFF8A3FFC);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: symptoms.map((symp) {
        final isSelected = selected.contains(symp);
        return ChoiceChip(
          label: Text(symp),
          selected: isSelected,
          selectedColor: primaryColor,
          backgroundColor: Colors.grey[200],
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
          ),
          onSelected: (_) {
            setState(() {
              if (isSelected) selected.remove(symp);
              else selected.add(symp);
            });
          },
        );
      }).toList(),
    );
  }
}