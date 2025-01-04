import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';

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
                subtitle: Text(station.location),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite, color: Colors.black), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up, color: Colors.black), label: 'Trends'),
          BottomNavigationBarItem(icon: Icon(Icons.trip_origin, color: Colors.black), label: 'My Trips'),
          BottomNavigationBarItem(icon: Icon(Icons.near_me, color: Colors.black), label: 'Nearby'),
          BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.black), label: 'Settings'),
        ],
        currentIndex: 1, // Set the current index for Favorites
        onTap: (index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/'); // Navigate to Home
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
