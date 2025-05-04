import 'package:flutter/material.dart';


class PeriodSymptomsScreen extends StatefulWidget {
  const PeriodSymptomsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PeriodSymptomsScreenState createState() => _PeriodSymptomsScreenState();
}

class _PeriodSymptomsScreenState extends State<PeriodSymptomsScreen> {
  final List<String> _commonSymptoms = [
    'Cramps',
    'Headache',
    'Bloating',
    'Fatigue',
    'Mood Swings',
    'Nausea',
    'Back Pain',
    'Acne',
    'Tender Breasts',
    'Diarrhea'
  ];

  final Set<String> _selectedSymptoms = {};
  final TextEditingController _customSymptomController = TextEditingController();

  void _toggleSymptom(String symptom) {
    setState(() {
      if (_selectedSymptoms.contains(symptom)) {
        _selectedSymptoms.remove(symptom);
      } else {
        _selectedSymptoms.add(symptom);
      }
    });
  }

  void _addCustomSymptom() {
    final symptom = _customSymptomController.text.trim();
    if (symptom.isNotEmpty) {
      setState(() {
        _selectedSymptoms.add(symptom);
        _customSymptomController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B0A3D), // Dark Violet
      appBar: AppBar(
        backgroundColor: const Color(0xFF8A3FFC), // Purple
        title: const Text(
          'Track Your Symptoms',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How are you feeling this week?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _commonSymptoms.map((symptom) {
                final isSelected = _selectedSymptoms.contains(symptom);
                return ChoiceChip(
                  label: Text(
                    symptom,
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF2B0A3D),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: const Color(0xFFFF5CA8), // Pink
                  backgroundColor: Colors.white,
                  onSelected: (_) => _toggleSymptom(symptom),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _customSymptomController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Add another symptom',
                labelStyle: const TextStyle(color: Colors.white),
                hintText: 'Eg. Dizziness',
                hintStyle: const TextStyle(color: Colors.white60),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF8A3FFC)),
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add, color: Color(0xFFFF5CA8)),
                  onPressed: _addCustomSymptom,
                ),
              ),
            ),
            SizedBox(width: double.infinity, // Makes the button full-width
              child: ElevatedButton(
                onPressed: () {
                  // Your onPressed function
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8A3FFC), // Purple
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 4, // Adds shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14), // Rounded corners
                  ),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                child: const Center(
                  child: Text("Save Symptoms"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}