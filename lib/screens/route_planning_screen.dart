import 'package:flutter/material.dart';
import '../widgets/search_bar_with_filter.dart'; // Correct import path

class RoutePlanningScreen extends StatelessWidget {
  const RoutePlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Planning'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBarWithFilter(), // Adding the SearchBarWithFilter widget
            const TextField(
              decoration: InputDecoration(labelText: 'Starting Point'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Destination'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement route planning functionality
              },
              child: const Text('Plan Route'),
            ),
          ],
        ),
      ),
    );
  }
}
