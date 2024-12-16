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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/Favourites.png')),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/Trends.png')),
            label: 'Trends',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/my trips.png')),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/nearby.png')),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/Settings.png')),
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
