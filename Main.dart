import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FuelCheckPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FuelCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              './assets/rectangle-1.svg', // Ensure you have this image in your assets
              fit: BoxFit.cover,
            ),
          ),
          // Logo and title
          Positioned(
            top: 189,
            left: -1,
            right: -1,
            child: Image.asset(
              './assets/logo-full-color-150-x-1.svg',
              width: 375,
              height: 299,
            ),
          ),
          // Dots alignment at the bottom
          Positioned(
            bottom: 285,
            left: 95,
            right: 95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return CircleAvatar(
                  radius: 9,
                  backgroundColor: Colors.black,
                );
              }),
            ),
          ),
          // Status Bar
          Positioned(
            top: 0,
            left: -1,
            right: 359,
            height: 44,
            child: Image.asset(
              './assets/i-os-status-bar-black.svg',
            ),
          ),
          // Line at the bottom
          Positioned(
            bottom: 10,
            left: 86,
            child: Container(
              width: 200,
              height: 10,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
