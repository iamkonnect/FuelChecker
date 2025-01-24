import 'package:flutter/material.dart';
import '../models/trend.dart'; // Import the Trend model

class TrendsScreen extends StatelessWidget {
  TrendsScreen({super.key}); // Remove const keyword

  final List<Trend> trends = [
    Trend(
      title: 'Petrol Price Trends',
      description: 'Current trends in petrol prices over the last month.',
      cheapestFillDay: 'Monday',
      priceRange: '\$1.20 - \$1.50',
    ),
    Trend(
      title: 'Best Days to Fill',
      description: 'The cheapest days to fill your tank this week.',
      cheapestFillDay: 'Wednesday',
      priceRange: '\$1.15 - \$1.45',
    ),
    Trend(
      title: 'Local Price Comparison',
      description: 'Compare petrol prices in your local area.',
      cheapestFillDay: 'Friday',
      priceRange: '\$1.10 - \$1.40',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trends'),
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
      body: ListView.builder(
        itemCount: trends.length,
        itemBuilder: (context, index) {
          final trend = trends[index];
          return Card(
            child: ListTile(
              title: Text(trend.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trend.description),
                  Text('Cheapest Fill Day: ${trend.cheapestFillDay}'),
                  Text('Price Range: ${trend.priceRange}'),
                ],
              ),
            ),
          );
        },
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
        currentIndex: 2, // Set the current index based on your logic
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
              // Stay on Trends
              break;
            case 3:
              Navigator.pushNamed(context, '/my_trip'); // Navigate to My Trips
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
