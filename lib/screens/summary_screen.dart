import 'package:flutter/material.dart';
import 'terms_and_conditions_screen.dart'; // Importing the TermsAndConditionsScreen
import 'fuel_type_selection_screen.dart'; // Importing the FuelTypeSelectionScreen

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('lib/assets/images/logo-full-color-150-x-1.png'), // Updated path
            const SizedBox(height: 32),
            const Text(
              'Welcome to Fuel Check. An app dedicated for your convenience!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'We aim to provide you live information and daily trends & analytics about the best or cheapest fuel prices in your local area.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 64),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TermsAndConditionsScreen()), // Navigate to TermsAndConditionsScreen
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

class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Screen'),
      ),
      body: const Center(
        child: Text('This is the next screen.'),
      ),
    );
  }
}
