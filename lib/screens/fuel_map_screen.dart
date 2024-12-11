import 'package:flutter/material.dart';

class FuelMapScreen extends StatefulWidget {
  final String fuelType;

  const FuelMapScreen({super.key, required this.fuelType});

  @override
  _FuelMapScreenState createState() => _FuelMapScreenState();
}

class _FuelMapScreenState extends State<FuelMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.near_me),
            onPressed: () {
              Navigator.pushNamed(context, '/nearby');
            },
            tooltip: 'Nearby',
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          // Map widget
          Image.asset('assets/fuel_map.png'), // Replace with your actual image asset

          // Fuel station markers
          const Positioned(
            top: 100,
            left: 100,
            child: FuelStationMarker(
              stationName: 'Totalenergies',
              blendE5Price: '\$1.40',
              dieselPrice: '\$1.25',
            ),
          ),
          const Positioned(
            top: 250,
            left: 200,
            child: FuelStationMarker(
              stationName: 'Engen',
              blendE5Price: '\$1.36',
              dieselPrice: '\$1.50',
            ),
          ),
          const Positioned(
            top: 350,
            left: 400,
            child: FuelStationMarker(
              stationName: 'Puma',
              blendE5Price: '\$1.36',
              dieselPrice: '\$1.50',
            ),
          ),
          const Positioned(
            top: 450,
            left: 550,
            child: FuelStationMarker(
              stationName: 'Puma',
              blendE5Price: '\$1.27',
              dieselPrice: '\$1.56',
            ),
          ),
          const Positioned(
            top: 100,
            right:  100,
            child: FuelStationMarker(
              stationName: 'Shell',
              blendE5Price: '\$1.45',
              dieselPrice: '\$1.30',
            ),
          ),
        ],
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

class FuelStationMarker extends StatelessWidget {
  final String stationName;
  final String blendE5Price;
  final String dieselPrice;

  const FuelStationMarker({super.key, 
    required this.stationName,
    required this.blendE5Price,
    required this.dieselPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Icon(Icons.local_gas_station, size: 40, color: Colors.red),
        Text(stationName, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('E5: $blendE5Price'),
        Text('Diesel: $dieselPrice'),
      ],
    );
  }
}
