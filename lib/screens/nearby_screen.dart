import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navigation_bar.dart'; // Import the custom bottom navigation bar

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  int _selectedIndex = 4; // Set the default index for Nearby

  /// Handles navigation based on the tapped index.
  void _onNavigationItemTapped(int index) {
    if (_selectedIndex == index)
      return; // Avoid unnecessary navigation for the current screen

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
            context, '/trends_screen'); // Navigate to Trends
        break;
      case 3:
        Navigator.pushReplacementNamed(
            context, '/my_trip'); // Navigate to My Trips
        break;
      case 4:
        // Stay on Nearby
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
          title: const Text('Nearby'),
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
        body: const Center(
          child: Text('Nearby Screen Content'),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onNavigationItemTapped,
        ),
      ),
    );
  }
}
