import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trends',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TrendsPage(),
    );
  }
}

class TrendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Status Bar placeholder
                Container(
                  height: 44,
                  width: double.infinity,
                  child: Image.asset('./assets/i-os-status-bar-black.svg'),
                ),
                SizedBox(height: 37),
                // Trend image
                Container(
                  height: 220,
                  width: 220,
                  child: Image.asset('./assets/image-2.svg'),
                ),
                SizedBox(height: 52),
                // Trends title
                Text(
                  'Trends',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                // Trends description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'Enjoy a quick glance of current trends and analytics on petrol prices, cheapest fill days, price ranges in your local area',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      color: Colors.black,
                      height: 1.75,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 60),
                // Dots indicator placeholder
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.circle, size: 10, color: Colors.orange),
                    SizedBox(width: 8),
                    Icon(Icons.circle, size: 10, color: Colors.black),
                    SizedBox(width: 8),
                    Icon(Icons.circle, size: 10, color: Colors.black),
                    SizedBox(width: 8),
                    Icon(Icons.circle, size: 10, color: Colors.black),
                  ],
                ),
                SizedBox(height: 70),
                // Next button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: MaterialButton(
                    onPressed: () {
                      // Navigate to the next page
                    },
                    color: Color(0xFFDF2626),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
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
                ),
                SizedBox(height: 10),
                // Bottom image placeholder
                Container(
                  height: 10,
                  width: 200,
                  child: Image.asset('./assets/rectangle-9.svg'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

