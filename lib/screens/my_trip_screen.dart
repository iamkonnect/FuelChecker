import 'package:flutter/material.dart';

class MyTripScreen extends StatelessWidget {
  const MyTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for trips
    final List<Map<String, dynamic>> trips = [
      {
        'fuelStation': 'Shell',
        'date': '2023-10-01',
        'destination': 'Paris, France',
        'distance': '15 km',
        'arrivalTime': '10:30 AM',
      },
      {
        'fuelStation': 'BP',
        'date': '2023-11-15',
        'destination': 'Miami, USA',
        'distance': '20 km',
        'arrivalTime': '2:00 PM',
      },
      {
        'fuelStation': 'Exxon',
        'date': '2023-12-20',
        'destination': 'Rocky Mountains',
        'distance': '30 km',
        'arrivalTime': '5:00 PM',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trip'),
      ),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(trips[index]['fuelStation']!),
              subtitle: Text('${trips[index]['date']} - ${trips[index]['destination']}'),
            ),
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
