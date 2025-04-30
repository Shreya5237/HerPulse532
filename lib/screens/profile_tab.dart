// lib/screens/profile_tab.dart
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String _name = 'Jane Doe';
  String _email = 'jane.doe@example.com';
  String _phone = '+1 234 567 890';
  bool _darkMode = false;
  double _profileCompletion = 0.6;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Profile Header with HerPulse logo background
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo_background.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: theme.scaffoldBackgroundColor,
                  child: CircleAvatar(
                    radius: 56,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _name,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(_email, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 2),
            Text(_phone, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Profile Completion', style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _profileCompletion,
                    backgroundColor: Colors.grey[300],
                    color: const Color(0xFF8A3FFC),
                    minHeight: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Settings list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _SectionHeader(title: 'Account'),
                  _buildListTile(
                    icon: Icons.manage_accounts,
                    title: 'Edit Profile',
                    subtitle: 'Change personal information',
                    onTap: () {},
                  ),
                  _buildListTile(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    subtitle: 'Update your password',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  _SectionHeader(title: 'Preferences'),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    secondary: const Icon(Icons.dark_mode),
                    value: _darkMode,
                    onChanged: (val) => setState(() => _darkMode = val),
                  ),
                  _buildListTile(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: 'English',
                    onTap: () {},
                  ),
                  _buildListTile(
                    icon: Icons.notification_important,
                    title: 'Notifications',
                    subtitle: 'Manage notification settings',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  _SectionHeader(title: 'Support'),
                  _buildListTile(
                    icon: Icons.help_outline,
                    title: 'Help & FAQ',
                    subtitle: 'Get assistance',
                    onTap: () {},
                  ),
                  _buildListTile(
                    icon: Icons.feedback_outlined,
                    title: 'Send Feedback',
                    subtitle: 'Share your thoughts',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF8A3FFC)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2B0A3D),
            ),
      ),
    );
  }
}
