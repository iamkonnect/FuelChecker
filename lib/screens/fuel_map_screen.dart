import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../local_gas_stations.dart'; // Import local data
import '../models/fuel_gas_station.dart'; // Adjust the path as needed
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/search_bar_with_filter_final.dart';

class FuelMapScreen extends StatefulWidget {
  final String fuelType;

  const FuelMapScreen({Key? key, required this.fuelType}) : super(key: key);

  @override
  FuelMapScreenState createState() => FuelMapScreenState();
}

class FuelMapScreenState extends State<FuelMapScreen> {
  LatLng? _currentLocation;
  List<GasStation> _fuelStations = [];
  List<GasStation> _nearbyStations = [];
  final Set<Marker> _markers = {};
  int _selectedIndex = 0;
  String _searchTerm = '';
  GoogleMapController? _mapController;
  String _locationName = '';
  bool _isLocationDetailsVisible = false;

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
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
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _nearbyStations = getNearbyStations(
            _fuelStations, position.latitude, position.longitude);
        _addFuelStationMarkers();

        _getCustomMarkerIcon().then((customIcon) {
          _markers.add(
            Marker(
              markerId: const MarkerId('current_location'),
              position: _currentLocation!,
              icon: customIcon,
              onTap: _toggleLocationDetails,
            ),
          );
        });

        _getLocationName(position.latitude, position.longitude);
      });
    }
  }

  Future<BitmapDescriptor> _getCustomMarkerIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
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

  void _addFuelStationMarkers() async {
    _markers.clear();
    for (final station in _nearbyStations) {
      if (_searchTerm.isEmpty ||
          station.name.toLowerCase().contains(_searchTerm.toLowerCase())) {
        // Load custom marker icon from stationIcon URL
        final BitmapDescriptor customIcon =
            await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(45, 45)),
          station.logoAsset, // Use logoAsset as the marker icon
        );

        _markers.add(
          Marker(
            markerId: MarkerId(station.id), // Use station.id as the markerId
            position: LatLng(station.latitude, station.longitude),
            icon: customIcon, // Use custom icon
            infoWindow: InfoWindow(
              title: station.name,
              snippet:
                  'Blend: \$${station.blendPrice}, Diesel: \$${station.dieselPrice}',
              onTap: () {
                // Show logoAsset in InfoWindow
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(station.logoAsset), // Display logoAsset
                        const SizedBox(height: 10),
                        Text('Blend: \$${station.blendPrice}'),
                        Text('Diesel: \$${station.dieselPrice}'),
                      ],
                    ),
                  ),
                );
              },
            ),
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

  void _toggleLocationDetails() {
    setState(() {
      _isLocationDetailsVisible = true;
    });
  }

  void _hideLocationDetails() {
    setState(() {
      _isLocationDetailsVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fuelStations = localGasStations.map((station) {
      return GasStation.fromMap(station['id'], station);
    }).toList();
    _getCurrentLocation();
  }

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
      case 3:
        Navigator.pushReplacementNamed(context, '/nearby');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  // Define the getNearbyStations method
  List<GasStation> getNearbyStations(
      List<GasStation> stations, double lat, double lng) {
    return stations.where((station) {
      double distance = Geolocator.distanceBetween(
        lat,
        lng,
        station.latitude,
        station.longitude,
      );
      return distance <= 5000; // Filter stations within 5 KM
    }).toList();
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
              _selectedIndex = 0;
            });
            Navigator.pushReplacementNamed(context, '/fuel_type');
          },
        ),
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
            from: '',
            to: '',
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
              height: MediaQuery.of(context).size.height * 0.2,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
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
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 24),
                      onPressed: _hideLocationDetails,
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
