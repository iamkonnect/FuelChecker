import 'package:flutter/material.dart';

void main() {
  runApp(FuelCheckApp());
}

class FuelCheckApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Check',
      home: FuelCheckHomePage(),
    );
  }
}

class FuelCheckHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.only(top: 44.0),
              child: Image.asset(
                './assets/logo-full-color-150-x-1.svg',
                width: 375.0,
                height: 299.0,
              ),
            ),
            // Back Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Container(
                width: 263.0,
                height: 48.0, // Adjusted height for better visual alignment
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Center(
                  child: Text(
                    'Back',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            // Sign Out Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: 279.0,
                height: 48.0, // Adjusted height for better visual alignment
                decoration: BoxDecoration(
                  color: Color(0xFFDF2626),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Center(
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
