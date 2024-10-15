import 'package:flutter/material.dart';

void main() {
  runApp(MyTripApp());
}

class MyTripApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyTripPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyTripPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 44), // Status bar height
                Image.asset(
                  './assets/image-10.png', // Update to .png if SVG isn't compatible
                  width: 224,
                  height: 219,
                ),
                SizedBox(height: 53),
                Text(
                  'My Trip',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color(0xFF000000),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36.5),
                  child: Text(
                    'My Trip to help you navigate and locate the cheapest gas station on your journey',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                SizedBox(height: 36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIndicator(isActive: true),
                    _buildIndicator(isActive: false),
                    _buildIndicator(isActive: false),
                    _buildIndicator(isActive: false),
                  ],
                ),
                SizedBox(height: 75),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFDF2626),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
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
                SizedBox(height: 10),
                Image.asset(
                  './assets/group-755.png', // Update to .png if SVG isn't compatible
                  height: 18,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator({required bool isActive}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.orange : Color(0xFF000000),
      ),
    );
  }
}
