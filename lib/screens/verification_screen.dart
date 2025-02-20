import 'package:flutter/material.dart';

class VerificationScreen extends StatelessWidget {
  final bool isVerified;

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
            Image.asset('assets/images/Fuelcheck logo 150by1.png'),
            const SizedBox(height: 20),
            Text(
              'Enter Your OTP code sent to your phone number: [phone number]',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: TextField(maxLength: 1, textAlign: TextAlign.center)),
                const SizedBox(width: 10),
                Expanded(child: TextField(maxLength: 1, textAlign: TextAlign.center)),
                const SizedBox(width: 10),
                Expanded(child: TextField(maxLength: 1, textAlign: TextAlign.center)),
                const SizedBox(width: 10),
                Expanded(child: TextField(maxLength: 1, textAlign: TextAlign.center)),
                const SizedBox(width: 10),
                Expanded(child: TextField(maxLength: 1, textAlign: TextAlign.center)),
                const SizedBox(width: 10),
                Expanded(child: TextField(maxLength: 1, textAlign: TextAlign.center)),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
