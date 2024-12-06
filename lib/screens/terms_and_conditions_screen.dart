import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Here are the terms and conditions. Please read them carefully before proceeding.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFDF2626), // Red color
  ),
  onPressed: () {
    // Navigate to the next screen or perform any action
    Navigator.pop(context, true);
  },
  child: const Text('Accept'),
),
          ],
        ),
      ),
    );
  }
}
