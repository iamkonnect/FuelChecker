import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'fuel_map_screen.dart'; // Import the FuelMapScreen

class NavigationApp extends StatefulWidget {
  const NavigationApp({super.key});

  @override
  State<NavigationApp> createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  int selectedIndex = 0;
  late GoogleMapController _mapController;
  LatLng _currentLocation = const LatLng(0, 0);
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _goToCurrentLocation() {
    _mapController.animateCamera(
      CameraUpdate.newLatLng(_currentLocation),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    // Handle navigation based on the selected index
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FuelMapScreen(fuelType: 'default')), // Pass fuelType
        );
        break;
      case 1:
        Navigator.pushNamed(context, '/favorites');
        break;
      case 2:
        Navigator.pushNamed(context, '/trends_screen');
        break;
      case 3:
        Navigator.pushNamed(context, '/my_trips'); // Updated to use named route
        break;
      case 4:
        Navigator.pushNamed(context, '/nearby');
        break;
      case 5:
        Navigator.pushNamed(context, '/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation App'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            _mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: _currentLocation,
          zoom: 14.0,
        ),
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCurrentLocation,
        child: const Icon(Icons.gps_fixed), // Updated to use Google Icons equivalent
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/assets/images/home-icon-silhouette.png',
              color: selectedIndex == 0 ? Colors.red : Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/assets/images/Favourites.png',
              color: selectedIndex == 1 ? Colors.red : Colors.black,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/assets/images/Trends.png',
              color: selectedIndex == 2 ? Colors.red : Colors.black,
            ),
            label: 'Trends',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/assets/images/my trips.png',
              color: selectedIndex == 3 ? Colors.red : Colors.black,
            ),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/assets/images/Settings.png',
              color: selectedIndex == 4 ? Colors.red : Colors.black,
            ),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/assets/images/nearby.png',
              color: selectedIndex == 5 ? Colors.red : Colors.black,
            ),
            label: 'Nearby',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
