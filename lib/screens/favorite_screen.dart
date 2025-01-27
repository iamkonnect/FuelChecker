import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart'; // Import the custom bottom navigation bar

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
          if (favoriteProvider.favorites.isEmpty) {
            return const Center(
              child: Text('No favorite fuel stations added.'),
            );
          }
          return ListView.builder(
            itemCount: favoriteProvider.favorites.length,
            itemBuilder: (context, index) {
              final station = favoriteProvider.favorites[index];
              return ListTile(
                title: Text(station.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Harare"), // Updated location
                    const SizedBox(height: 4),
                    const Text(
                      '\$1.2 per gallon', // Updated fuel price
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Fuel Type: Unleaded', // Dummy fuel type
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Description: This is a popular fuel station with great service.', // Dummy description
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 1, // Set the current index for Favorites
        onItemTapped: (index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/fuel_map'); // Navigate to Fuel Map
              break;
            case 1:
              // Stay on Favorites
              break;
            case 2:
              Navigator.pushNamed(context, '/trends_screen'); // Navigate to Trends
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
