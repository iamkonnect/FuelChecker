import 'package:flutter/material.dart';
import 'location_button_screen.dart'; // Import the LocationButtonScreen

class MyTripButtonScreen extends StatelessWidget {
  const MyTripButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trip'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/assets/images/my trips.png', // Updated to use the new icon
              height: 120, // Adjust height for better visibility
            ),
            const SizedBox(height: 20),
            const Text(
              'My Trips', // Title text
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Bold title
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0), // Add horizontal padding
              child: Text(
                'My Trip to help you navigate and locate the cheapest gas station on your journey',
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
color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
color: Colors.orange, // Change to orange for the second dot
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Adjusted space before the button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LocationButtonScreen()), // Navigate to LocationButtonScreen
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
