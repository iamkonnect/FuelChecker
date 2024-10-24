import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerificationScreen(),
    );
  }
}

class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/icon-x.png'), // Change the icon if needed
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'VERIFICATION',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Thank you for the verification',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xFF787B82),
              ),
            ),
            SizedBox(height: 80),
            Image.asset(
              'assets/vector.png', // Change to correct asset path
              width: 148,
              height: 139.29,
            ),
            SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Color(0xFFDF2626),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  // Navigate to the next page
                },
                child: Text(
                  'Enter',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
