import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importing the LoginScreen

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _brightness = 0.5; // Default brightness value

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

  void _showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Theme',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('Light Theme'),
                leading: Radio<String>(
                  value: 'light',
                  groupValue: 'theme', // Replace with actual state
                  onChanged: (String? value) {
                    Navigator.pop(context); // Close BottomSheet
                    // Implement theme selection logic here
                    print('Selected Theme: Light');
                  },
                ),
              ),
              ListTile(
                title: const Text('Dark Theme'),
                leading: Radio<String>(
                  value: 'dark',
                  groupValue: 'theme', // Replace with actual state
                  onChanged: (String? value) {
                    Navigator.pop(context); // Close BottomSheet
                    // Implement theme selection logic here
                    print('Selected Theme: Dark');
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Adjust Brightness',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Slider(
                value: _brightness,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: (_brightness * 100).toStringAsFixed(0) + '%',
                onChanged: (double value) {
                  setState(() {
                    _brightness = value;
                  });
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Brightness: ${(_brightness * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
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
                onTap: () => _showThemeBottomSheet(context),
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
                  Navigator.pushNamed(context, '/about');
                },
              ),
              const SizedBox(height: 16),
              _buildSettingCard(
                icon: Icons.help,
                title: 'Help',
                onTap: () {
                  Navigator.pushNamed(context, '/help');
                },
              ),
              const SizedBox(height: 16),
              _buildSettingCard(
                icon: Icons.feedback,
                title: 'Feedback',
                onTap: () {
                  Navigator.pushNamed(context, '/feedback');
                },
              ),
              const SizedBox(height: 16),
              _buildSettingCard(
                icon: Icons.report,
                title: 'Report an Issue',
                onTap: () {
                  Navigator.pushNamed(context, '/report');
                },
              ),
              const SizedBox(height: 16),
              _buildSettingCard(
                icon: Icons.remove_circle,
                title: 'Deactivate Account',
                onTap: () {
                  Navigator.pushNamed(context, '/deactivate');
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
                    backgroundColor: Colors.red, // Set background color to red
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
