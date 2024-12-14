import 'package:flutter/material.dart';
import 'fuel_map_screen.dart'; // Importing the FuelMapScreen

class VerificationScreen extends StatelessWidget {
  final bool isVerified; // New variable to check verification status

  const VerificationScreen({Key? key, required this.isVerified}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Verification'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isVerified ? 'Thank you for the verification' : 'The verification is incorrect, try again',
                style: TextStyle(
                  fontSize: isVerified ? 30 : 16,
                  fontWeight: isVerified ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20),
              if (!isVerified) // Show button only if verification failed
                ElevatedButton(
                  onPressed: () {
                    // Navigate back to the OTP screen
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  child: Text(
                    'Back to OTP',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              const SizedBox(height: 50),
              Icon(
                Icons.check_circle,
                size: 100,
                color: isVerified ? Colors.green : Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
