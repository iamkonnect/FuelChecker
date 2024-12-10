import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class NavigationApp extends StatefulWidget {
  const NavigationApp({Key? key}) : super(key: key);

  @override
  State<NavigationApp> createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  // Google Map Controller
  late GoogleMapController _mapController;

  // User's current location
  late LatLng _currentLocation;

  // Destination fuel station
  final LatLng _destination = const LatLng(33.9248, 18.4232); // Harare, Zimbabwe

  // Map Markers
  final Set<Marker> _markers = {};

  // Location Permission and Data
  final Location _location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  // Set up the map and initialize location services
  @override
  void initState() {
    super.initState();
    _initLocationService();
  }

  // Initialize location service
  Future<void> _initLocationService() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await _location.getLocation();
    setState(() {
      _currentLocation = LatLng(_locationData!.latitude!, _locationData!.longitude!);
      _markers.add(
        Marker(
          markerId: const MarkerId('Current Location'),
          position: _currentLocation,
          infoWindow: const InfoWindow(title: 'Your Location'),
        ),
      );
      _markers.add(
        Marker(
          markerId: const MarkerId('Destination'),
          position: _destination,
          infoWindow: const InfoWindow(title: 'Puma Petroleum, Harare'),
        ),
      );
    });
  }

  // Build the Google Map
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation App'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _currentLocation,
          zoom: 14.0,
        ),
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCurrentLocation,
        tooltip: 'Current Location',
        child: const Icon(Icons.my_location),
      ),
    );
  }

  // Move the camera to the current location
  Future<void> _goToCurrentLocation() async {
    _mapController.animateCamera(
      CameraUpdate.newLatLng(_currentLocation),
    );
  }
}
