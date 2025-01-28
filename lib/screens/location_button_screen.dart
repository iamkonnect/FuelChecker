import 'package:flutter/material.dart';
import 'favorite_button_screen.dart'; // Import the FavoriteButtonScreen

class LocationButtonScreen extends StatelessWidget {
  const LocationButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Button'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.location_pin,
              size: 120, // Adjust icon size for consistency
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            const Text(
              'Location Services', // Title text
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Bold title
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0), // Add horizontal padding
              child: Text(
                'Access to your location to improve location searches and estimate travel distance.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18), // Unbolded description
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black, // First dot
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black, // Second dot
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange, // Third dot changed to orange
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black, // Fourth dot
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
    MaterialPageRoute(builder: (context) => const FavoriteButtonScreen()), // Navigate to FavoriteButtonScreen
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(327, 48), // Set the size of the button
                backgroundColor: Colors.red, // Set button color to red
                textStyle: const TextStyle(
                  color: Colors.white, // Change text color to white
                ),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
