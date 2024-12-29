import 'package:flutter/material.dart';

class StationDetailsScreen extends StatelessWidget {
  const StationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Station Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Station Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Address: 123 Fuel St, City, Country'),
            const Text('Contact: (123) 456-7890'),
            const SizedBox(height: 20),
            const Text('Amenities:'),
            const Text('- Restrooms'),
            const Text('- Convenience Store'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement navigation to the station
              },
              child: const Text('Navigate'),
            ),
          ],
        ),
      ),
    );
  }
}
