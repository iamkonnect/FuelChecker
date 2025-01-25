import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Fuel Check',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App logo
            Image.asset(
              'lib/assets/images/logo-full-color-150-x-1.png',
              height: 100,
            ),
            const SizedBox(height: 16.0),

            // Version
            const Text(
              'Version 1.0',
              style: TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24.0),

            // App description
            const Text(
              'Fuel Check provides real-time information about fuel prices at service stations across Zimbabwe. It helps you find the cheapest fuel near you, get directions to service stations, and report price discrepancies.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32.0),

            // Features
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Features',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '• Find the cheapest fuel anywhere in Zimbabwe.\n'
                '• Get directions to any service station.\n'
                '• Search for fuel by type or brand.\n'
                '• Report price discrepancies to ZERA.',
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 32.0),

            // Disclaimer
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Disclaimer',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Do not use your phone while driving. Traffic penalties may apply. Always use Fuel Check responsibly.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32.0),

            // Reporting price discrepancies
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Report Price Discrepancies',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'If you notice a price difference between Fuel Check and the pump, you can report it via:\n\n'
              '1. The Fuel Check app (Attach evidence like a photo of signage or a receipt).\n'
              '2. The ZERA website (Provide necessary details and evidence).',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32.0),

            // Footer
            const Divider(color: Colors.grey),
            const SizedBox(height: 8.0),
            const Text(
              '© 2025 Fuel Check. All rights reserved.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
