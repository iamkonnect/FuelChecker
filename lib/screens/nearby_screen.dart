import 'package:flutter/material.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('lib/assets/images/Favourites.png'), color: Colors.black), label: 'Favorites'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('lib/assets/images/Trends.png'), color: Colors.black), label: 'Trends'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('lib/assets/images/my trips.png'), color: Colors.black), label: 'My Trips'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('lib/assets/images/nearby.png'), color: Colors.black), label: 'Nearby'),
          BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.black), label: 'Settings'),
        ],
        currentIndex: 4, // Set the current index for Nearby
        selectedItemColor: const Color(0xFFDF2626), // Highlight color for selected item

        onTap: (index) {
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
              Navigator.pushNamed(context, '/settings'); // Navigate to Settings
              break;
          }
        },
      ),
    );
  }
}
