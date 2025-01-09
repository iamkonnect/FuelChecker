import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../models/fuel_price.dart'; // Import FuelStation model
import '../widgets/search_bar_with_filter_final.dart'; // Correct import path

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
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _nearbyStations = getNearbyStations(_fuelStations, position.latitude, position.longitude);
      _addFuelStationMarkers();
    });
  }

  void _addFuelStationMarkers() {
    _markers.clear();
    for (final station in _nearbyStations) {
      _markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(station.latitude, station.longitude),
          child: const Icon(Icons.local_gas_station, size: 40, color: Colors.red),
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
        child: const Icon(Icons.location_on, size: 40, color: Colors.green), // Current location marker
      ),
    );
    _markers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: toCoordinates,
        child: const Icon(Icons.location_on, size: 40, color: Colors.blue), // Destination marker
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
            child: SearchBarWithFilter(), // Floating SearchBarWithFilter
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
              Navigator.pushNamed(context, '/trends');
              break;
            case 3:
              Navigator.pushNamed(context, '/my-trips');
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
