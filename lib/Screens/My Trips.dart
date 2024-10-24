import 'package:flutter/material.dart';

void main() {
  runApp(MyTripApp());
}

class MyTripApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFDF2626),
      ),
      home: MyTripPage(),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 219,
                child: Image.asset('assets/image-10.svg'),
              ),
              const SizedBox(height: 40),
              const Text(
                'My Trip',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'My Trip to help you navigate and locate the cheapest gas station on your journey',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    height: 1.75, // Equivalent to lineHeight of 35px
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  DotIndicator(isActive: true),
                  DotIndicator(isActive: false),
                  DotIndicator(isActive: false),
                  DotIndicator(isActive: false),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 279,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle your next action
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: Color(0xFFDF2626),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
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
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({Key? key, required this.isActive}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.black : Colors.orange,
      ),
    );
  }
}
