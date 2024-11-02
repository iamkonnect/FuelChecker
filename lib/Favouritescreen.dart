import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favourite Screen',
      home: FavouriteScreen(),
    );
  }
}

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 44), // Space for the status bar
              Icon(
                Icons.star,
                size: 150,
                color: Colors.black,
              ),
              Column(
                children: [
                  Text(
                    'Favourite',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Customize and personalize by adding your favourite stations in the app.\nPush notifications to alert you when your station’s prices have dropped!',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: Colors.black,
                        height: 1.75,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.black,
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.orange,
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle Next button press
                      },
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), backgroundColor: Color(0xFFDF2626), // Background color
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32,
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
                  ),
                  SizedBox(height: 45),
                ],
              ),
              Container(
                width: 200,
                height: 10,
                color: Colors.black,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
