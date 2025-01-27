import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navigation_bar.dart'; // Import the custom bottom navigation bar

class NearbyScreen extends StatelessWidget {
  const NearbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby'),
      ),
      body: const Center(
        child: Text('Nearby Screen Content'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 4, // Set the current index for Nearby
        onItemTapped: (index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/fuel_map'); // Navigate to Fuel Map
              break;
            case 1:
              Navigator.pushNamed(context, '/favorites'); // Navigate to Favorites
              break;
            case 2:
              Navigator.pushNamed(context, '/trends_screen'); // Navigate to Trends
              break;
            case 3:
              Navigator.pushNamed(context, '/my_trip'); // Navigate to My Trips
              break;
            case 4:
              // Stay on Nearby
              break;
            case 5:
              Navigator.pushNamed(context, '/settings_screen'); // Navigate to Settings
              break;
          }
        },
      ),
    );
  }
}
