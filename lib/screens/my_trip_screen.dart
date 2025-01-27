import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navigation_bar.dart'; // Import the custom bottom navigation bar

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
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 3, // Set the current index for My Trips
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
