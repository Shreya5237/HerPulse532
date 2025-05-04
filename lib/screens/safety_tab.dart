import 'package:flutter/material.dart';

class SafetyTab extends StatelessWidget {
  const SafetyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SOS Alert Card
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 6,
              color: Colors.red.shade400,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 36),
                    const SizedBox(height: 10),
                    const Text(
                      "Send SOS Alert",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.send),
                        label: const Text("Alert Emergency Contacts"),
                        onPressed: () {
                          // Implement SOS action
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Emergency Contact Info Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Emergency Contact Numbers",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildContactTile("Primary Contact", "9876543210"),
                  const SizedBox(height: 10),
                  _buildContactTile("Secondary Contact", "1234567890"),
                  const SizedBox(height: 10),
                  _buildContactTile("Hospital (if pregnant)", "0123456789"),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile(String label, String number) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                number,
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.green),
            onPressed: () {
              // Implement call functionality
            },
          )
        ],
      ),
    );
  }
}

