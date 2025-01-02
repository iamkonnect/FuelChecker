import 'package:flutter/material.dart';
import 'trends_button_screen.dart'; // Importing the TrendsButtonScreen
// Importing the SignUpScreen

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
                      color: Colors.white, // Change text color to white
                    ),
                  ),
                  child: const Text(
                    'Back to OTP',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Change text color to white
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Icon(
                Icons.check_circle,
                size: 100,
                color: isVerified ? Colors.green : Colors.red,
              ),
              const SizedBox(height: 20),
              // New Enter Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TrendsButtonScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 33, 33),
                  fixedSize: const Size(327, 51), // Set the size of the button
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Change text color to white
                  ),
                ),
                child: const Text(
                  'Enter',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Change text color to white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
