import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Profile Picture URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement save functionality
              },
              child: const Text('Save Changes'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement logout functionality
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
</create_file;>
