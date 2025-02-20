import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navigation_bar.dart'; // Import the custom bottom navigation bar

class MyTripScreen extends StatefulWidget {
  const MyTripScreen({Key? key}) : super(key: key);

  @override
  State<MyTripScreen> createState() => _MyTripScreenState();
}

class _MyTripScreenState extends State<MyTripScreen> {
  int _selectedIndex = 3; // Set the default index for My Trips

  /// Handles navigation based on the tapped index.
  void _onNavigationItemTapped(int index) {
    if (_selectedIndex == index) {
      return; // Avoid unnecessary navigation for the current screen
    }


    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(
            context, '/fuel_map'); // Navigate to Fuel Map
        break;
      case 1:
        Navigator.pushReplacementNamed(
            context, '/favorites'); // Navigate to Favorites
        break;
      case 2:
        Navigator.pushReplacementNamed(
            context, '/analytics'); // Navigate to Trends
        break;
      case 3:
        // Stay on My Trips
        break;
      case 4:
        Navigator.pushReplacementNamed(
            context, '/nearby'); // Navigate to Nearby
        break;
      case 5:
        Navigator.pushReplacementNamed(
            context, '/settings'); // Navigate to Settings
        break;
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          // Handle back button press
          setState(() {
            _selectedIndex = 0; // Set Home as active
          });
          Navigator.pushReplacementNamed(
              context, '/fuel_map'); // Navigate to Home
        }
      },

      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Trip'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                _selectedIndex = 0; // Set Home as active
              });
              Navigator.pushReplacementNamed(
                  context, '/fuel_map'); // Navigate to Home
            },
          ),
        ),
        body: ListView.builder(
          itemCount: fuelStations.length,
          itemBuilder: (context, index) {
            final station = fuelStations[index];
            return Card(
              child: ListTile(
                title: Text(station['name']!),
                subtitle: Text('${station['fuelType']} - ${station['price']}'),
                trailing: Text(station['location']!),
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
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onNavigationItemTapped,
        ),
      ),
    );
  }
}
