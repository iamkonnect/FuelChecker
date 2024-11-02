import 'package:flutter/material.dart';

void main() => runApp(HelpScreen());

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HelpPage(),
    );
  }
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf7f7f7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('./assets/arrow-left.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Help',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            SectionTitle(text: "Find the cheapest fuel on my route"),
            DescriptionText(text: "1. Fuel Check gives you..."),
            SizedBox(height: 40),
            SectionTitle(text: "Set a favourite station"),
            DescriptionText(text: "1. Fuel Check gives you..."),
            SizedBox(height: 40),
            SectionTitle(text: "Notification"),
            DescriptionText(text: "1. Fuel Check gives you..."),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 10,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('./assets/rectangle-9.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
        fontSize: 16,
        height: 1.5,
        color: Colors.black,
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  final String text;

  const DescriptionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.normal,
        fontSize: 16,
        height: 1.5,
        color: Colors.black,
      ),
    );
  }
}
