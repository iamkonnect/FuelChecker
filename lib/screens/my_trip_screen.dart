import 'package:flutter/material.dart';

class MyTripScreen extends StatelessWidget {
  const MyTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for fuel stations
    final List<Map<String, String>> fuelStations = [
      {
        'name': 'Station A',
        'fuelType': 'Diesel',
        'price': '\$3.50',
        'location': '123 Main St, City A'
      },
      {
        'name': 'Station B',
        'fuelType': 'Diesel',
        'price': '\$3.60',
        'location': '456 Elm St, City B'
      },
      {
        'name': 'Station C',
        'fuelType': 'Diesel',
        'price': '\$3.55',
        'location': '789 Oak St, City C'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trip'),
      ),
      body: ListView.builder(
        itemCount: fuelStations.length,
        itemBuilder: (context, index) {
          final station = fuelStations[index];
          return ListTile(
            title: Text(station['name']!),
            subtitle: Text('${station['fuelType']} - ${station['price']}'),
            trailing: Text(station['location']!),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add trip action
        },
        child: const Icon(Icons.add),
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
          if (index == 3) {
            // Stay on My Trips
            return;
          }
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
