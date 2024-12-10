import 'package:flutter/material.dart';

class MyTripScreen extends StatelessWidget {
  const MyTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trip'),
      ),
      body: const Center(
        child: Text('My Trip Screen'),
      ),
    );
  }
}
