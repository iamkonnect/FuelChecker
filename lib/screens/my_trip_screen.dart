import 'package:flutter/material.dart';

class MyTripScreen extends StatelessWidget {
  const MyTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trip'),
      ),
      body: const Center(
        child: Text('My Trip Screen'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Trends'),
          BottomNavigationBarItem(icon: Icon(Icons.trip_origin), label: 'My Trips'),
          BottomNavigationBarItem(icon: Icon(Icons.near_me), label: 'Nearby'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: 3, // Set the current index for My Trips
        onTap: (index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/'); // Navigate to Home
              break;
            case 1:
              Navigator.pushNamed(context, '/favorites'); // Navigate to Favorites
              break;
            case 2:
              Navigator.pushNamed(context, '/trends_screen'); // Navigate to Trends
              break;
            case 3:
              // Stay on My Trips
              break;
            case 4:
              Navigator.pushNamed(context, '/nearby'); // Navigate to Nearby
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
