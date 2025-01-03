import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Notifications'),
              value: true, // This should be dynamic
              onChanged: (bool value) {
                // Implement notification toggle functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile Details'),
              onTap: () {
                Navigator.pushNamed(context, '/profile-detail');
              },
            ),
            ListTile(
              title: const Text('Language'),
              subtitle: const Text('English'),
              onTap: () {
                // Implement language selection functionality
              },
            ),
            ListTile(
              title: const Text('Theme'),
              subtitle: const Text('Light'),
              onTap: () {
                // Implement theme selection functionality
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
