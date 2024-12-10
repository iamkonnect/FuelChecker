import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  _TermsAndConditionsScreenState createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('US Terms And Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'US Terms And Conditions',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color(0xFFDF2626)),
            ),
            const SizedBox(height: 20.0),
            const Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Thank you for using Fuel Checker! We\'re happy you\'re here. Please read this Terms of Service agreement carefully before accessing or using Fuel Checker. Because it is such an important contract between us and our users, we have tried to make it as clear as possible. For your convenience, we have presented these terms in a short non-binding summary followed by the full legal terms.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            CheckboxListTile(
              title: const Text('I have read and I accept the terms and conditions'),
              value: _isAccepted,
              onChanged: (bool? value) {
                setState(() {
                  _isAccepted = value ?? false;
                });
              },
            ),
            const SizedBox(height: 10.0),
            const Text('I have read and I accept the terms and conditions'),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDF2626), // Red color
              ),
              onPressed: _isAccepted ? () {
                // Navigate to the next screen or perform any action
                Navigator.pop(context, true);
              } : () {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please accept the terms and conditions to proceed.')),
                  );
                }
              },
              child: const Text('Accept'),
            )
          ],
        ),
      ),
    );
  }
}
