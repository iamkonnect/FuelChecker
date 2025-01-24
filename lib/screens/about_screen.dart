import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/mapbackground.png'), // Updated path
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text('About Content Here'),
        ),
      ),
    );
  }
}
