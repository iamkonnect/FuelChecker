import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/mapbackground.png'), // Updated path
            const SizedBox(height: 32),
            const Text('Enter your OTP'),
            // Add your OTP input field and other widgets here
          ],
        ),
      ),
    );
  }
}
