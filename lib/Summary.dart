import 'package:flutter/material.dart';

void main() {
  runApp(FuelCheckApp());
}

class FuelCheckApp extends StatelessWidget {
  const FuelCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Check',
      theme: ThemeData(
        primaryColor: Color(0xFFF7F7F7),
        fontFamily: 'Manrope',
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 36.0),
            child: Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Color(0xFFDF2626),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50),
          Image.asset(
            './assets/logo-full-color-150-x-1.svg',
            width: 200,
            height: 100,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          Text(
            'Welcome to Fuel Check. An app dedicated for your convenience!\n\nWe aim to provide you live information and daily trend & analytics about the best or cheapest fuel prices in your local area.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF787B82),
            ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 36.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDF2626),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              onPressed: () {
                // Navigate to the next screen
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
