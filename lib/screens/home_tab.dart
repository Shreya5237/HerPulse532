
import 'package:flutter/material.dart';
import 'package:herpulse532/screens/cycle_tracker/cycle_tracking_page.dart';



class HomeTab extends StatelessWidget {
  final VoidCallback? onViewReportsTap;
  const HomeTab({super.key, this.onViewReportsTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32), // extra bottom padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🌟 Hero Banner with shadow
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF8A3FFC), Color(0xFFB48EF1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hey Warrior! 💪",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "You're stronger than you think. Keep going!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/hero_banner.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 📊 Today's Stats
          Text(
            "Today's Stats",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard(
                icon: Icons.directions_walk,
                title: "Steps",
                value: "5,200",
                color: Colors.orangeAccent,
              ),
              _buildStatCard(
                icon: Icons.local_fire_department,
                title: "Calories",
                value: "320 kcal",
                color: Colors.redAccent,
              ),
              _buildStatCard(
                icon: Icons.favorite,
                title: "Heart",
                value: "78 bpm",
                color: Colors.pinkAccent,
              ),
            ],
          ),

          // 📌 Smart Alert Card
          const SizedBox(height: 16),
          Card(
            color: const Color(0xFFFDECEA),
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: ListTile(
              leading: const Icon(Icons.notification_important, color: Colors.redAccent),
              title: const Text("Period starts in 3 days"),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  // TODO: Dismiss reminder logic
                },
              ),
            ),
          ),

          const SizedBox(height: 14),

          // 🆘 Emergency Quick Actions
          Text(
            "Emergency Actions",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2B0A3D),
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('SOS Alert Sent!')),
                  );
                },
                icon: const Icon(Icons.warning, color: Colors.white),
                label: const Text("SOS Alert"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,    // ensures white text/icon
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Finding Safe Places...')),
                  );
                },
                icon: const Icon(Icons.location_on, color: Colors.white),
                label: const Text("Safe Places"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,    // ensures white text/icon
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // 🩺 Health Snapshot
          Text(
            'Your Health Snapshot',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSnapshotCard('Cycle Days', '22 Days', Icons.date_range),
              _buildSnapshotCard('Mood', 'Stable', Icons.sentiment_satisfied),
              _buildSnapshotCard('Next Event', 'Dr. Visit', Icons.calendar_today),
            ],
          ),

          const SizedBox(height: 30),

          // ⚡ Quick Actions
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.3,   // tiles taller, less overflow
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildQuickActionTile(context, 'Add Event', Icons.add),
              _buildQuickActionTile(context, 'View Reports', Icons.insert_chart, onTap: onViewReportsTap),
              _buildQuickActionTile(
                context,
                'Track Cycle',
                Icons.timeline,
                onTap: () {
                  Navigator.of(context).pushNamed('/cycleTracker');
                },
              ),
              _buildQuickActionTile(context, 'View Tips', Icons.info),
            ],
          ),

          const SizedBox(height: 30),

          // ⏰ Upcoming Reminders
          Text(
            'Upcoming Reminders',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 10),
          _buildReminderTile('Dr. Appointment', 'Tomorrow at 3 PM'),
          _buildReminderTile('Medication', 'Daily 9 AM'),
        ],
      ),
    );
  }

  // 📊 Stat Card Widget
  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // 🔍 Snapshot Card Widget
  Widget _buildSnapshotCard(String title, String value, IconData icon) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.purple, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ⚡ Quick Action Tile
  Widget _buildQuickActionTile(
    BuildContext context,
    String title,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap ?? () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title tapped!')),
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.purple, size: 40),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ⏰ Reminder Tile
  Widget _buildReminderTile(String title, String time) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1F9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
