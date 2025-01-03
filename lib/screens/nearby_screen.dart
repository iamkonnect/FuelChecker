import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'feedback_screen.dart'; // Import the FeedbackScreen
import '../models/fuel_price.dart'; // Import FuelStation model

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({super.key});

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  Position? _currentPosition;
  List<FuelStation> _fuelStations = [];
  List<FuelStation> _nearbyStations = [];

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
    setState(() {
      _currentPosition = position;
      _nearbyStations = getNearbyStations(_fuelStations, position.latitude, position.longitude);
    });
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

  @override
  Widget build(BuildContext context) {

    // Show feedback prompt after displaying fuel stations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _nearbyStations.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Feedback'),
              content: const Text('Would you like to provide feedback on the fuel stations displayed?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    if (mounted) {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FeedbackScreen()), // Navigate to FeedbackScreen
                      );
                    }
                  },
                ),
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    if (mounted) {
                      Navigator.of(context).pop(); // Close the dialog
                    }
                  },
                ),
              ],
            );
          },
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Nearby'),
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : _nearbyStations.isEmpty
              ? const Center(child: Text('No fuel stations within 5km.'))
              : ListView.builder(
                  itemCount: _nearbyStations.length,
                  itemBuilder: (context, index) {
                    final fuelStation = _nearbyStations[index];
                    final distance = fuelStation.distanceFrom(
                      _currentPosition!.latitude,
                      _currentPosition!.longitude,
                    );
                return Card(
                  child: ListTile(
                    leading: Image.asset('lib/assets/images/logo-full-color-150-x-1.png'),
                    title: Text(fuelStation.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${distance.toStringAsFixed(1)} km away'),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text('Blend ES: \$${fuelStation.blendESPrice.toStringAsFixed(2)}'),
                            const SizedBox(width: 16),
                            Text('Diesel: \$${fuelStation.dieselPrice.toStringAsFixed(2)}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
