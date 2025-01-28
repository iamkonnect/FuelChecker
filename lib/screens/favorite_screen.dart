import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart'; // Import the custom bottom navigation bar

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedIndex = 1; // Set the default index for Favorites

  /// Handles navigation based on the tapped index.
  void _onNavigationItemTapped(int index) {
    if (_selectedIndex == index)
      return; // Avoid unnecessary rebuilds for the current screen

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(
            context, '/fuel_map'); // Navigate to Home
        break;
      case 1:
        // Stay on Favorites
        break;
      case 2:
        Navigator.pushReplacementNamed(
            context, '/trends_screen'); // Navigate to Trends
        break;
      case 3:
        Navigator.pushReplacementNamed(
            context, '/my_trip'); // Navigate to My Trips
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        setState(() {
          _selectedIndex = 0; // Set Home as active
        });
        Navigator.pushReplacementNamed(
            context, '/fuel_map'); // Navigate to Home
        return false; // Prevent default back behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
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
          selectedIndex: _selectedIndex,
          onItemTapped: _onNavigationItemTapped,
        ),
      ),
    );
  }
}
