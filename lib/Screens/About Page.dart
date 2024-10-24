import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AboutPage(),
  ));
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 35,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Image.asset(
            './assets/arrow-left.png', // Make sure this is the correct path for your asset
            width: 15,
            height: 12.05,
          ),
          onPressed: () {
            // Navigate back or to the appropriate page
          },
        ),
        backgroundColor: Color(0xFFF7F7F7),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Did you know there can be a difference of 40 cents per litre between the cheapest and most expensive service station?',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                height: 1.5,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Fuel Check gives you...',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.5,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Fuel Types',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize:
