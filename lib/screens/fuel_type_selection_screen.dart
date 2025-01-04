import 'package:flutter/material.dart';
import 'fuel_map_screen.dart'; // Add this import statement

class FuelTypeSelectionScreen extends StatefulWidget {
  const FuelTypeSelectionScreen({super.key});

  @override
  State<FuelTypeSelectionScreen> createState() => _FuelTypeSelectionScreenState();
}

class _FuelTypeSelectionScreenState extends State<FuelTypeSelectionScreen> {
  String? _selectedFuelType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/logo-full-color-150-x-1.png', height: 300),
            const SizedBox(height: 32.0),
            const Text(
              'Please select your Fuel Type',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedFuelType,
              hint: const Text('Choose your fuel type'),
              items: const [
                DropdownMenuItem(value: 'Blend E5', child: Text('Blend E5')),
                DropdownMenuItem(value: 'Diesel', child: Text('Diesel')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedFuelType = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Your preferred fuel type will be used to send notifications. You can configure and make adjustments on your fuel types and brand filtering at anytime in these settings.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                if (_selectedFuelType != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FuelMapScreen(fuelType: _selectedFuelType!),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16.0),
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  // Remove foregroundColor from textStyle
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/Favourites.png')),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/Trends.png')),
            label: 'Trends',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/my trips.png')),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/nearby.png')),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/Settings.png')),
            label: 'Settings',
          ),
        ],
        currentIndex: 0, // Set the current index based on your logic
        selectedItemColor: const Color(0xFFDF2626), // Change selected color
        unselectedItemColor: Colors.black, // Default color
        onTap: (index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              // Navigate to Home
              break;
            case 1:
              // Navigate to Favorites
              break;
            case 2:
              // Navigate to Trends
              break;
            case 3:
              // Navigate to My Trips
              break;
            case 4:
              // Navigate to Nearby
              break;
            case 5:
              // Navigate to Settings
              break;
          }
        },
      ),
    );
  }
}
