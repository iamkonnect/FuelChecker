import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert'; // Add this import for JSON decoding
import 'package:http/http.dart' as http; // Add this import for HTTP requests

class FuelMapScreen extends StatefulWidget {
  final String fuelType;

  const FuelMapScreen({super.key, required this.fuelType});

  @override
  _FuelMapScreenState createState() => _FuelMapScreenState();
}

class _FuelMapScreenState extends State<FuelMapScreen> {
  LatLng _currentLocation = const LatLng(0, 0); // Default location
  final Set<Marker> _markers = {}; // Initialize markers
  int _selectedIndex = 1; // Default to Fuel Map

  Future<void> _fetchFuelStations() async {
    const String apiUrl = 'https://api.here.com/v1/fuelstations'; // Replace with actual API endpoint
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Authorization': 'Bearer YOUR_API_KEY', // Replace with your API key
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> stations = data['fuelStations']['fuelStation'];
      for (var station in stations) {
        double latitude = station['position']['latitude'];
        double longitude = station['position']['longitude'];
        String name = station['name'];
        double price = station['fuelPrice'][0]['price']; // Assuming first price is the relevant one

        _markers.add(
          Marker(
            point: LatLng(latitude, longitude),
                child: Column(
                    children: [
                        const Icon(Icons.local_gas_station, size: 40, color: Colors.red),
                        Text(name),
                        Text('\$${price.toStringAsFixed(2)}'),
                    ],
            ),
          ),
        );
      }
    } else {
      throw Exception('Failed to load fuel stations');
    }
  }

  void _addFuelStationMarkers() async {
    await _fetchFuelStations();
    setState(() {});
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _addFuelStationMarkers(); // Fetch and display markers
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/nearby');
        break;
      case 1: // Stay on Fuel Map
      case 2:
        Navigator.pushNamed(context, '/settings');
        break;
    }
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
      body: const Stack(
        children: <Widget>[
          Center(
            child: Text('Map functionality has been removed.'),
          ),
          Positioned(
            top: 100,
            left: 100,
            child: FuelStationMarker(
              stationName: 'Totalenergies',
              blendE5Price: '\$1.40',
              dieselPrice: '\$1.25',
            ),
          ),
          Positioned(
            top: 250,
            left: 200,
            child: FuelStationMarker(
              stationName: 'Engen',
              blendE5Price: '\$1.36',
              dieselPrice: '\$1.50',
            ),
          ),
          Positioned(
            top: 350,
            left: 400,
            child: FuelStationMarker(
              stationName: 'Puma',
              blendE5Price: '\$1.36',
              dieselPrice: '\$1.50',
            ),
          ),
          Positioned(
            top: 100,
            right: 100,
            child: FuelStationMarker(
              stationName: 'Shell',
              blendE5Price: '\$1.45',
              dieselPrice: '\$1.30',
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Fuel Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class FuelStationMarker extends StatelessWidget {
  final String stationName;
  final String blendE5Price;
  final String dieselPrice;

  const FuelStationMarker({
    super.key,
    required this.stationName,
    required this.blendE5Price,
    required this.dieselPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Icon(Icons.local_gas_station, size: 40, color: Colors.red),
        Text(stationName, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('E5: $blendE5Price'),
        Text('Diesel: $dieselPrice'),
      ],
    );
  }
}
