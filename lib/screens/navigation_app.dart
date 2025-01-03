import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'my_trip_screen.dart'; // Import the MyTripScreen

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
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/favorites');
        break;
      case 2:
        Navigator.pushNamed(context, '/trends_screen');
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyTripScreen()),
        );
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
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
