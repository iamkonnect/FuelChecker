import 'package:flutter/material.dart';
// Importing the CounterScreen
import 'screens/welcome_screen_v7.dart'; // Importing the WelcomeScreen
// Importing the SignupScreen
import 'screens/signup_screen_v7.dart'; // Importing the SignupScreen
import 'screens/otp_verification_screen_v4.dart'; // Importing the OTP Verification Screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Checker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterScreen(), // Set the home screen to CounterScreen
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Counter: 0'), // Placeholder for counter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WelcomeScreenV7()),
                    );
                  },
                  child: const Text('Go to Welcome Screen'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreenV7()),
                    );
                  },
                  child: const Text('Go to Signup Screen'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OtpVerificationScreenV4(phoneNumber: '')), // Placeholder for phone number
                    );
                  },
                  child: const Text('Go to OTP Verification Screen'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
