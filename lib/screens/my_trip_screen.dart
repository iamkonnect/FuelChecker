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
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('lib/assets/images/Favourites.png'), color: Colors.black), label: 'Favorites'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('lib/assets/images/Trends.png'), color: Colors.black), label: 'Trends'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('lib/assets/images/my trips.png'), color: Colors.black), label: 'My Trips'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('lib/assets/images/nearby.png'), color: Colors.black), label: 'Nearby'),
          BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.black), label: 'Settings'),
        ],
        currentIndex: 3, // Set the current index for My Trips
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
