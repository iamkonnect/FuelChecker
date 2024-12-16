import 'package:flutter/material.dart';

class TrendsButtonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trends'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/assets/images/Trends.png', // Adding the Trends image
              height: 200, // Adjust height as needed
            ),
            const SizedBox(height: 20),
            // const Icon(
            //   Icons.grid_on,
            //   size: 100,
            //   color: Colors.black,
            // ),
            const SizedBox(height: 20),
            const Text(
              'Enjoy a quick glance of\ncurrent trends and analytics\non petrol prices, cheapest fill\ndays, price ranges in your\nlocal area',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to the trends screen
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(327, 48), // Set the size of the button
                backgroundColor: Colors.red, // Set button color to red
                textStyle: const TextStyle(
                  color: Colors.white, // Set text color to white
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
