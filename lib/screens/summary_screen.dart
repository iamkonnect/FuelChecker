import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/logo-full-color-150-x-1.png', height: 200), // Updated path
            const SizedBox(height: 32),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/mapbackground.png'), // Updated path
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Text('Summary Content Here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
