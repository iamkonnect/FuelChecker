import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AboutPage(),
  ));
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  TextStyle _textStyle({required FontWeight fontWeight, required double fontSize}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: fontWeight,
      fontSize: fontSize,
      height: 1.5,
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text(
          'About',
          style: _textStyle(fontWeight: FontWeight.w700, fontSize: 35),
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/arrow-left.png', // Ensure this is the correct path for your asset
            width: 15,
            height: 12.05,
          ),
          onPressed: () => Navigator.pop(context), // Navigate back to the previous page
        ),
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Did you know there can be a difference of 40 cents per litre between the cheapest and most expensive service station?',
              style: _textStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Fuel Check gives you...',
              style: _textStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            const SizedBox(height: 40),
            Text(
              'Fuel Types',
              style: _textStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 10),
            // You can add more content here, such as a list of fuel types or descriptions.
          ],
        ),
      ),
    );
  }
}