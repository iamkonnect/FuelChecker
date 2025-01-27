import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package
import '../models/fuel_price.dart'; // Import FuelStation model
import '../widgets/search_bar_with_filter_final.dart' as searchBar; // Correct import path with alias
import '../widgets/custom_bottom_navigation_bar.dart'; // Import the custom bottom navigation bar

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

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    );
    if (mounted) { // Check if the widget is still mounted
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _nearbyStations = getNearbyStations(_fuelStations, position.latitude, position.longitude);
        _addFuelStationMarkers();
      });
    }
  }

  void _addFuelStationMarkers() {
    _markers.clear();
    for (final station in _nearbyStations) {
      _markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(station.latitude, station.longitude),
          child: const Icon(Icons.local_gas_station, size: 40, color: Colors.red), // Updated to use Google Icons equivalent
        ),
      );
    }
    _clusterMarkers();
  }

  void _clusterMarkers() {
    // Simple clustering logic to avoid overlapping markers
    final clusteredMarkers = <LatLng, List<Marker>>{};

    for (final marker in _markers) {
      final key = LatLng(marker.point.latitude, marker.point.longitude);
      if (!clusteredMarkers.containsKey(key)) {
        clusteredMarkers[key] = [];
      }
      clusteredMarkers[key]!.add(marker);
    }

    _markers.clear();
    clusteredMarkers.forEach((key, markers) {
      if (markers.length > 1) {
        // If there are overlapping markers, create a single marker for the cluster
        _markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: key,
            child: const Icon(Icons.local_gas_station, size: 40, color: Colors.orange), // Updated to use Google Icons equivalent
          ),
        );
      } else {
        // If no overlap, add the original marker
        _markers.add(markers.first);
      }
    });
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
      body: Stack(
        children: [
          _currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : FlutterMap(
                  options: MapOptions(
                    initialCenter: _currentLocation!,
                    initialZoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: _markers.toList(),
                    ),
                  ],
                ),
          Positioned(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            child: searchBar.SearchBarWithFilter(
              getCoordinates: getCoordinates, // Pass the getCoordinates method
              from: 'Your From Location', // Replace with actual variable or state
              to: 'Your To Location', // Replace with actual variable or state
              searchTerm: 'Your Search Term', // Replace with actual variable or state
            ), // Floating SearchBarWithFilter
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
              Navigator.pushNamed(context, '/trends_screen'); // Updated to correct route
              break;
            case 3:
              Navigator.pushNamed(context, '/my_trip'); // Updated to correct route
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
