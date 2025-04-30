import 'package:flutter/material.dart';

class SafetyTab extends StatefulWidget {
  const SafetyTab({Key? key}) : super(key: key);

  @override
  _SafetyTabState createState() => _SafetyTabState();
}

class _SafetyTabState extends State<SafetyTab> {
  final List<Contact> _contacts = [
    Contact(name: 'Mom', number: '+91 9876543210'),
    Contact(name: 'Best Friend', number: '+91 9876543211'),
  ];

  bool get isPregnant => true; // Placeholder: fetch from user profile

  void _showAddContactDialog({bool hospital = false}) {
    final nameController = TextEditingController();
    final numberController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(hospital ? 'Add Hospital Number' : 'Add Emergency Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final number = numberController.text.trim();
              if (name.isNotEmpty && number.isNotEmpty) {
                setState(() => _contacts.add(Contact(name: name, number: number)));
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8A3FFC), Color(0xFFFF5CA8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              // SOS Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.warning_amber_rounded, size: 28, color: Colors.white),
                  label: const Text('Send SOS Alert', style: TextStyle(fontSize: 18, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D0A50),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 8,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('SOS Alert Sent 🚨'),
                        content: const Text('Your emergency contacts have been notified.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),
              // Contacts List Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Emergency Contacts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.white, size: 28),
                      onPressed: () => _showAddContactDialog(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _contacts.length + (isPregnant ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (isPregnant && index == _contacts.length) {
                        return Card(
                          color: const Color(0xFFFCE4EC),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: const Icon(Icons.local_hospital, color: Color(0xFF8A3FFC)),
                            title: const Text('Hospital / Clinic'),
                            subtitle: const Text('Add hospital number'),
                            trailing: IconButton(
                              icon: const Icon(Icons.add, color: Color(0xFF8A3FFC)),
                              onPressed: () => _showAddContactDialog(hospital: true),
                            ),
                          ),
                        );
                      }
                      final contact = _contacts[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 3,
                        child: ListTile(
                          leading: const Icon(Icons.phone, color: Color(0xFF8A3FFC)),
                          title: Text(contact.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(contact.number),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => setState(() => _contacts.removeAt(index)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Contact {
  final String name;
  final String number;
  Contact({required this.name, required this.number});
}