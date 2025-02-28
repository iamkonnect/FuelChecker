import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // Geocoding package
import '../models/fuel_price.dart'; // Import FuelStation model
import '../widgets/custom_bottom_navigation_bar.dart'; // Import the custom bottom navigation bar
import '../widgets/search_bar_with_filter_final.dart'; // Import the search bar with filter

class FuelMapScreen extends StatefulWidget {
  final String fuelType;

  const FuelMapScreen({Key? key, required this.fuelType}) : super(key: key);

  @override
  FuelMapScreenState createState() => FuelMapScreenState();
}

class FuelMapScreenState extends State<FuelMapScreen> {
  LatLng? _currentLocation;
  List<FuelStation> _fuelStations = [];
  List<FuelStation> _nearbyStations = [];
  final Set<Marker> _markers = {};
  int _selectedIndex = 0; // Default to Home (Index 0)
  String _searchTerm = ''; // Variable to hold the search term
  GoogleMapController? _mapController;
  String _locationName = ''; // Variable to hold the location name
  bool _isLocationDetailsVisible =
      false; // Track whether to show the bottom sheet

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return; // Permissions denied, handle accordingly
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    );
    if (mounted) {
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _nearbyStations = getNearbyStations(
            _fuelStations, position.latitude, position.longitude);
        _addFuelStationMarkers();

        // Add a marker for the current location
        _getCustomMarkerIcon().then((customIcon) {
          _markers.add(
            Marker(
              markerId: const MarkerId('current_location'),
              position: _currentLocation!,
              icon: customIcon, // Use the custom icon
              onTap: _toggleLocationDetails,
            ),
          );
        });

        // Fetch the location name (address)
        _getLocationName(position.latitude, position.longitude);
      });
    }
  }

  Future<BitmapDescriptor> _getCustomMarkerIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)), // Adjust size as needed
      'assets/images/location1.png',
    );
  }

  Future<void> _getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _locationName =
              '${place.street}, ${place.locality}, ${place.country}';
        });
      }
    } catch (e) {
      print('Error fetching location name: $e');
    }
  }

  void _addFuelStationMarkers() {
    _markers.clear();
    for (final station in _nearbyStations) {
      if (_searchTerm.isEmpty ||
          station.name.toLowerCase().contains(_searchTerm.toLowerCase())) {
        _markers.add(
          Marker(
            markerId: MarkerId(station.name),
            position: LatLng(station.latitude, station.longitude),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
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
    return null;
  }

  // Function to show the bottom sheet
  void _toggleLocationDetails() {
    setState(() {
      _isLocationDetailsVisible = true; // Show the bottom sheet
    });
  }

  // Function to hide the bottom sheet
  void _hideLocationDetails() {
    setState(() {
      _isLocationDetailsVisible = false; // Hide the bottom sheet
    });
  }

  @override
  void initState() {
    super.initState();
    _fuelStations = [
      // Initialize fuel stations here
    ];
    _getCurrentLocation();
  }

  /// Navigates to the respective screen based on the index.
  void _onNavigationItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/fuel_map');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/favorites');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/analytics');
        break;
      case 3: // Nearby (previously My Trip)
        Navigator.pushReplacementNamed(context, '/nearby');
        break;
      case 4: // Settings (previously Nearby)
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Map'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _selectedIndex = 0; // Set Home as active
            });
            Navigator.pushReplacementNamed(
                context, '/fuel_type'); // Navigate to fuel type selection
          },
        ), // No back button on the Home screen
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
                      _mapController = controller;
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onNavigationItemTapped,
      ),
      bottomSheet: _isLocationDetailsVisible
          ? Container(
              height: MediaQuery.of(context).size.height *
                  0.2, // Set height to 20% of the screen
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Center contents horizontally
                      children: [
                        const SizedBox(
                            height: 10), // Reduced space for the close button
                        const Text(
                          'Current Location Details',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Latitude: ${_currentLocation?.latitude}, Longitude: ${_currentLocation?.longitude}',
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Location: $_locationName',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8, // Adjusted position for the close icon
                    right: 8, // Adjusted position for the close icon
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 24), // Close icon
                      onPressed: _hideLocationDetails, // Close the bottom sheet
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
