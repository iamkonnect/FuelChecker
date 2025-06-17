import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

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

void main() {
  runApp(MaterialApp(
    home: OtpVerificationScreen(),
  ));
  // This command is used to get the dependencies listed in the pubspec.yaml file.
  // It is not part of the Dart code and should be run in the terminal.
  // flutter pub get
}
