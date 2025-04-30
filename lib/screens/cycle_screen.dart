// lib/screens/cycle_screen.dart

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CycleScreen extends StatefulWidget {
  const CycleScreen({Key? key}) : super(key: key);

  @override
  _CycleScreenState createState() => _CycleScreenState();
}

class _CycleScreenState extends State<CycleScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;
  String _flowIntensity = 'Medium';
  double _painLevel = 5;
  final Set<String> _symptoms = {};
  String _productPreference = 'Pad';
  bool _setupComplete = false;

  // Placeholder events map for TableCalendar
  late final Map<DateTime, List<String>> _events;

  @override
  void initState() {
    super.initState();
    _events = {};
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (date != null) {
      setState(() {
        if (isStart) _startDate = date;
        else _endDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menstrual Cycle Tracker'),
        backgroundColor: const Color(0xFF8A3FFC),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _setupComplete ? _buildTrackerView(context) : _buildSetupForm(),
      ),
    );
  }

  Widget _buildSetupForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Setup Your Cycle Tracker',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Enter your cycle details below to receive personalized insights and predictions.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 24),

          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Period Dates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _pickDate(context, true),
                        child: Text(_startDate == null ? 'Start Date' : 'Start: ${_startDate!.toShortDateString()}'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _pickDate(context, false),
                        child: Text(_endDate == null ? 'End Date' : 'End: ${_endDate!.toShortDateString()}'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Flow Intensity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: ['Light', 'Medium', 'Heavy'].map((level) {
                    return ChoiceChip(
                      label: Text(level),
                      selected: _flowIntensity == level,
                      onSelected: (_) => setState(() => _flowIntensity = level),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Average Pain Level', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Slider(
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: _painLevel.round().toString(),
                  value: _painLevel,
                  onChanged: (val) => setState(() => _painLevel = val),
                ),
              ],
            ),
          ),

          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Symptoms', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ...['Cramps', 'Bloating', 'Fatigue', 'Mood Swings'].map((sym) {
                  return CheckboxListTile(
                    title: Text(sym),
                    value: _symptoms.contains(sym),
                    onChanged: (val) => setState(() => val! ? _symptoms.add(sym) : _symptoms.remove(sym)),
                  );
                }).toList(),
              ],
            ),
          ),

          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Sanitary Product Preference', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ...['Pad', 'Tampon', 'Menstrual Cup'].map((prod) => RadioListTile<String>(
                      title: Text(prod),
                      value: prod,
                      groupValue: _productPreference,
                      onChanged: (val) => setState(() => _productPreference = val!),
                    )),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_startDate != null && _endDate != null) {
                  setState(() => _setupComplete = true);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8A3FFC),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              child: const Text('Save & Continue', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackerView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TableCalendar(
          firstDay: DateTime.now().subtract(const Duration(days: 365)),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          focusedDay: DateTime.now(),
          eventLoader: (day) => _events[DateTime(day.year, day.month, day.day)] ?? [],
          calendarStyle: const CalendarStyle(
            markerDecoration: BoxDecoration(color: Color(0xFF8A3FFC), shape: BoxShape.circle),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          onDaySelected: (selectedDay, focusedDay) {
            // Future: allow marking symptoms/pain per day
          },
        ),

        const SizedBox(height: 20),
        Text(
          'Smart Alerts & Recommendations',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(Icons.notifications_active, color: Color(0xFF8A3FFC)),
          title: const Text('Sanitary product reminders'),
        ),
        ListTile(
          leading: const Icon(Icons.restaurant_menu, color: Color(0xFF8A3FFC)),
          title: const Text('Personalized diet & lifestyle tips'),
        ),
        ListTile(
          leading: const Icon(Icons.medical_services, color: Color(0xFF8A3FFC)),
          title: const Text('Pain reduction monitoring'),
        ),

        const SizedBox(height: 20),
        Text(
          'Pain Trend Chart',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Container(
            height: 200,
            alignment: Alignment.center,
            child: const Text('Pain Trend Chart Coming Soon'),
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

extension DateHelpers on DateTime {
  String toShortDateString() {
    return "\${this.day}/\${this.month}/\${this.year}";
  }
}