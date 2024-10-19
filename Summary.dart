import 'package:flutter/material.dart';

void main() => runApp(FuelCheckApp());

class FuelCheckApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Welcome!',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: 40,
                  color: Color(0xFFDF2626),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              './assets/logo-full-color-150-x-1.svg',
              width: 200,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Welcome to Fuel Check. An app dedicated for your convenience!\n\nWe aim to provide you live information and daily trend & analytics about the best or cheapest fuel prices in your local area.',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xFF787B82),
                  height: 1.37,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFDF2626),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  // Navigate to the next screen (fuel station search dashboard)
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
            Image.asset(
              './assets/rectangle-9.svg',
              width: 200,
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
