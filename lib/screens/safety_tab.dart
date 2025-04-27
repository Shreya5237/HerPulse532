import 'package:flutter/material.dart';

class SafetyTab extends StatelessWidget {
  const SafetyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SOS Button
          ElevatedButton.icon(
            onPressed: () {
              _showSOSDialog(context);
            },
            icon: const Icon(Icons.warning, color: Colors.white),
            label: const Text(
              "Send SOS Alert",
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Emergency Contacts
          const Text(
            "Emergency Contacts",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8A3FFC),
            ),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.red),
                  title: Text("Mom"),
                  subtitle: Text("+91 9876543210"),
                ),
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.red),
                  title: Text("Best Friend"),
                  subtitle: Text("+91 9876543211"),
                ),
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.red),
                  title: Text("Local Police"),
                  subtitle: Text("100"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // SOS Dialog function
  void _showSOSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('SOS Alert Sent 🚨'),
        content: const Text('Emergency contacts have been notified! Stay safe.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
