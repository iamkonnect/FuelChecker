import 'package:flutter/material.dart';
import '../widgets/search_bar_with_filter_final.dart'; // Updated import path
// Import LatLng type

class RoutePlanningScreen extends StatelessWidget {
  const RoutePlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController fromController = TextEditingController();
    final TextEditingController toController = TextEditingController();
    const String searchTerm = ''; // Initialize search term

    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Planning'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBarWithFilter(
              getCoordinates: (String location) async {
                // Implement your getCoordinates logic here
                return null; // Replace with actual logic
              },
              from: fromController.text,
              to: toController.text,
              searchTerm: searchTerm,
            ), // Adding the SearchBarWithFilter widget
            TextField(
              controller: fromController,
              decoration: const InputDecoration(labelText: 'Starting Point'),
            ),
            TextField(
              controller: toController,
              decoration: const InputDecoration(labelText: 'Destination'),
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