import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.red.shade700),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 28),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SwitchListTile(
                  title: const Text('Notifications'),
                  value: true,
                  onChanged: (bool value) {
                    // Implement notification toggle functionality
                  },
                ),
              ),
              const SizedBox(height: 16),
              _buildSettingCard(
                icon: Icons.person,
                title: 'Profile Details',
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              const SizedBox(height: 16),
              _buildSettingCard(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'English',
                onTap: () {
                  // Implement language selection functionality
                },
              ),
              const SizedBox(height: 16),
              _buildSettingCard(
                icon: Icons.color_lens,
                title: 'Theme',
                subtitle: 'Light',
                onTap: () {
                  // Implement theme selection functionality
                },
              ),
              const SizedBox(height: 16),
              _buildSettingCard(
                icon: Icons.analytics,
                title: 'Analytics',
                onTap: () {
                  // Implement analytics functionality
                },
              ),
              const SizedBox(height: 16),
              _buildSettingCard(
                icon: Icons.info,
                title: 'About',
                onTap: () {
                  // Implement about functionality
                },
              ),
              const SizedBox(height: 16),
              _buildSettingCard(
                icon: Icons.help,
                title: 'Help',
                onTap: () {
                  // Implement help functionality
                },
              ),
              const SizedBox(height: 16),
              _buildSettingCard(
                icon: Icons.feedback,
                title: 'Feedback',
                onTap: () {
                  // Implement feedback functionality
                },
              ),
              const SizedBox(height: 16),
              _buildSettingCard(
                icon: Icons.report,
                title: 'Report an Issue',
                onTap: () {
                  // Implement issue reporting functionality
                },
              ),
              const SizedBox(height: 16),
              _buildSettingCard(
                icon: Icons.remove_circle,
                title: 'Deactivate Account',
                onTap: () {
                  // Implement account deactivation functionality
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16),
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
