import 'dart:math'; // Import for Random class
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package
import '../models/fuel_price.dart'; // Import FuelStation model
import '../services/fuel_station_data.dart'; // Import fuel station data
import '../widgets/search_bar_with_filter_final.dart' as searchBar; // Correct import path with alias

class FuelMapScreen extends StatefulWidget {
  final String fuelType;

  const FuelMapScreen({super.key, required this.fuelType});

  @override
  FuelMapScreenState createState() => FuelMapScreenState();
}

class FuelMapScreenState extends State<FuelMapScreen> {
  LatLng? _currentLocation;
  List<FuelStation> _fuelStations = fuelStations.map((data) => FuelStation(
    name: data['name']!,
    location: data['town']!,
    latitude: (data['latitude'] as num).toDouble(), // Cast to double
    longitude: (data['longitude'] as num).toDouble(), // Cast to double
    blendESPrice: 0.0, // Placeholder for price
    dieselPrice: 0.0, // Placeholder for price
  )).toList();
  List<FuelStation> _nearbyStations = [];
  final Set<Marker> _markers = {};
  int _selectedIndex = 0; // Default to Home

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _nearbyStations = getNearbyStations(_fuelStations, position.latitude, position.longitude);
      _addFuelStationMarkers();
    });
  }

  // Method to get coordinates from location name
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

  void _addFuelStationMarkers() {
    _markers.clear();
    for (final station in _nearbyStations) {
      _markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(station.latitude, station.longitude),
          child: Icon(Icons.local_gas_station, size: 40, color: Colors.red),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fuelStations = [
      FuelStation(
        name: 'Puma Petroleum',
        location: 'Ardbennie Harare',
        latitude: -17.8419,
        longitude: 31.0678,
        blendESPrice: 1.39,
        dieselPrice: 1.59,
      ),
      FuelStation(
        name: 'Shell',
        location: 'Avondale Harare',
        latitude: -17.7936,
        longitude: 31.0425,
        blendESPrice: 1.36,
        dieselPrice: 1.50,
      ),
      FuelStation(
        name: 'Totalenergies',
        location: 'Belgravia Harare',
        latitude: -17.8056,
        longitude: 31.0489,
        blendESPrice: 1.27,
        dieselPrice: 1.40,
      ),
      FuelStation(
        name: 'Engen',
        location: 'Mikocheni A',
        latitude: -6.7656832, // Updated latitude for Engen
        longitude: 39.1769131, // Updated longitude for Engen
        blendESPrice: (1.20 + (0.10 * (Random().nextInt(10)))), // Random price for blend ES
        dieselPrice: (1.30 + (0.10 * (Random().nextInt(10)))), // Random price for diesel
      ),
      FuelStation(
        name: 'Puma',
        location: 'Masaki',
        latitude: -6.7689603, // Updated latitude for Puma
        longitude: 39.2472892, // Updated longitude for Puma
        blendESPrice: 1.19, // Dummy price
        dieselPrice: 1.40, // Dummy price
      ),
      FuelStation(
        name: 'Lake Oil',
        location: 'Sinza',
        latitude: -6.7950, // Dummy latitude for Lake Oil
        longitude: 39.2278, // Dummy longitude for Lake Oil
        blendESPrice: 1.46, // Dummy price
        dieselPrice: 1.24, // Dummy price
      ),
    ];
    _getCurrentLocation();
  }

  void updateMarkers(LatLng fromCoordinates, LatLng toCoordinates) {
    _markers.clear();
    _markers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: _currentLocation!,
        child: Icon(Icons.location_on, size: 40, color: Colors.green), // Current location marker
      ),
    );
    _markers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: toCoordinates,
        child: Icon(Icons.location_on, size: 40, color: Colors.blue), // Destination marker
      ),
    );
    setState(() {}); // Refresh the map with new markers

    // Call the directions calculation method
    calculateDirections(_currentLocation!, toCoordinates);
  }

  void calculateDirections(LatLng fromCoordinates, LatLng toCoordinates) {
    // Placeholder for directions calculation logic
    // This could involve calling a mapping API to get directions
    print('Calculating directions from $fromCoordinates to $toCoordinates');
  }

  // Method to filter fuel stations based on search term
  List<FuelStation> filterFuelStations(String searchTerm) {
    return _fuelStations.where((station) {
      return station.name.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();
  }

  // Method to update markers with filtered stations
  void updateMarkersWithFilteredStations(List<FuelStation> filteredStations) {
    _markers.clear();
    for (final station in filteredStations) {
      _markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(station.latitude, station.longitude),
          child: Icon(Icons.local_gas_station, size: 40, color: Colors.red),
        ),
      );
    }
    setState(() {}); // Refresh the map with new markers
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/Favourites.png')),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/Trends.png')),
            label: 'Trends',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/my trips.png')),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/nearby.png')),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/Settings.png')),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFDF2626),
        unselectedItemColor: Colors.black,
        onTap: (index) {
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
              Navigator.pushNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }
}
