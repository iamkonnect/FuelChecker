import 'package:flutter/material.dart';

void main() {
  runApp(FuelCheckApp());
}

class FuelCheckApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Check',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Inter', // Ensure to add the custom font to your pubspec.yaml
      ),
      home: FuelSelectionScreen(),
    );
  }
}

class FuelSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 44.0), // For status bar spacing
              Image.asset(
                './assets/logo-full-color-150-x-1.svg', // Replace with correct path if needed
                width: 100, // Rescale as per your need
              ),
              SizedBox(height: 20.0),
              Text(
                'Please select your Fuel Type',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF000000),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 11.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Color(0xFFF3F4F6),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Choose your fuel type',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0x1E232E80),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'Your preferred fuel type will be used to send notifications. You can configure and make adjustments on your fuel types and brand filtering at anytime in these settings.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF000000),
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Add navigation or functionality here
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFDF2626),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                ),
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.0), // For padding to bottom
              Container(
                color: Color(0xFF000000),
                width: 200.0,
                height: 10.0,
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
