import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package
import '../models/fuel_price.dart'; // Import FuelStation model
import '../widgets/custom_bottom_navigation_bar.dart'; // Import the custom bottom navigation bar
import '../widgets/search_bar_with_filter_final.dart'; // Import the search bar with filter

class FuelMapScreen extends StatefulWidget {
  final String fuelType;

  const FuelMapScreen({super.key, required this.fuelType});

  @override
  FuelMapScreenState createState() => FuelMapScreenState();
}

class FuelMapScreenState extends State<FuelMapScreen> {
  LatLng? _currentLocation;
  List<FuelStation> _fuelStations = [];
  List<FuelStation> _nearbyStations = [];
  final Set<Marker> _markers = {};
  int _selectedIndex = 0; // Default to Home
  String _searchTerm = ''; // Variable to hold the search term

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        // Permissions are denied, handle accordingly
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    );
    if (mounted) {
      // Check if the widget is still mounted
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _nearbyStations = getNearbyStations(
            _fuelStations, position.latitude, position.longitude);
        _addFuelStationMarkers();
      });
    }
  }

  void _addFuelStationMarkers() {
    _markers.clear();
    for (final station in _nearbyStations) {
      if (_searchTerm.isEmpty || station.name.toLowerCase().contains(_searchTerm.toLowerCase())) {
        _markers.add(
          Marker(
            markerId: MarkerId(station.name), // Use name as the marker ID
            position: LatLng(station.latitude, station.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // Updated to use Google Maps marker
          ),
        );
      }
    }
  }

  Future<LatLng?> getCoordinates(String location) async {
    try {
      List<Location> locations = await locationFromAddress(location);
      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      print('Error getting coordinates: $e');
    }
    return null; // Return null if no coordinates found
  }

  @override
  void initState() {
    super.initState();
    _fuelStations = [
      // Initialize fuel stations here
    ];
    _getCurrentLocation();
  }

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
      body: Column(
        children: [
          SearchBarWithFilter(
            getCoordinates: getCoordinates,
            from: '', // Pass any required parameters
            to: '', // Pass any required parameters
            searchTerm: _searchTerm,
          ),
          Expanded(
            child: _currentLocation == null
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _currentLocation!,
                      zoom: 13.0,
                    ),
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      // Additional setup if needed
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });

          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/favorites');
              break;
            case 2:
              Navigator.pushNamed(
                  context, '/trends_screen'); // Updated to correct route
              break;
            case 3:
              Navigator.pushNamed(
                  context, '/my_trip'); // Updated to correct route
              break;
            case 4:
              Navigator.pushNamed(context, '/nearby');
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
