import 'package:flutter/material.dart';
// Importing the TrendsButtonScreen

class VerificationScreen extends StatelessWidget {
  final bool isVerified; // New variable to check verification status

  const VerificationScreen({super.key, required this.isVerified});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Verification'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Fuelcheck logo 150by1.png'), // Add logo
            const SizedBox(height: 20),
            Text(
              'Enter Your OTP code sent to your phone number: [phone number]', // OTP prompt
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row( // Row for OTP input fields
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: TextField(maxLength: 1, textAlign: TextAlign.center)), // OTP field 1
                const SizedBox(width: 10),
                Expanded(child: TextField(maxLength: 1, textAlign: TextAlign.center)), // OTP field 2
                const SizedBox(width: 10),
                Expanded(child: TextField(maxLength: 1, textAlign: TextAlign.center)), // OTP field 3
                const SizedBox(width: 10),
                Expanded(child: TextField(maxLength: 1, textAlign: TextAlign.center)), // OTP field 4
                const SizedBox(width: 10),
                Expanded(child: TextField(maxLength: 1, textAlign: TextAlign.center)), // OTP field 5
                const SizedBox(width: 10),
                Expanded(child: TextField(maxLength: 1, textAlign: TextAlign.center)), // OTP field 6
              ],
            ),
            const SizedBox(height: 20),
            // Additional UI elements can be added here
          ],
        ),
      ),
    );
  }
}
