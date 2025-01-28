import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../services/fuel_station_service.dart'; // Ensure this path is correct

class CustomMarker extends StatelessWidget {
  final String name;
  final String logoUrl;

  const CustomMarker({super.key, required this.name, required this.logoUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(logoUrl, width: 40, height: 40),
        Text(name),
      ],
    );
  }
}

class FuelMapWidget extends StatefulWidget {
  const FuelMapWidget({super.key});

  @override
  _FuelMapWidgetState createState() => _FuelMapWidgetState();
}

class _FuelMapWidgetState extends State<FuelMapWidget> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  List<FuelStation> _fuelStations = [];
  final List<LatLng> _routePoints = []; // To store route points

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        ),
      );
      setState(() {});
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  Future<void> _fetchFuelStations() async {
    FuelStationService service = FuelStationService();
    _fuelStations = await service.fetchFuelStations(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      'your_fuel_type', // Replace with actual fuel type
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fuel Map')),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                zoom: 13,
              ),
              markers: Set<Marker>.of(_fuelStations.map((station) {
                return Marker(
                  markerId: MarkerId(station.name),
                  position: LatLng(station.latitude, station.longitude),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                  infoWindow: InfoWindow(title: station.name),
                );
              })),
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  points: _routePoints,
                  color: Colors.blue,
                  width: 4,
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                if (_currentPosition != null) {
                  _mapController!.moveCamera(
                    CameraUpdate.newLatLng(
                      LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                    ),
                  );
                }
              },
            ),
    );
  }
}
