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
  final Map<PolylineId, Polyline> _polylines = {};
  int _selectedIndex = 0;
  String _searchTerm = '';
  GoogleMapController? _mapController;
  String _locationName = '';
  bool _isLocationDetailsVisible = false;
  GasStation? _selectedStation;

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
              onTap: () {
                _toggleLocationDetails();
              },
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
        final BitmapDescriptor customIcon =
            await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(45, 45)),
          station.logoAsset,
        );

        _markers.add(
          Marker(
            markerId: MarkerId(station.id),
            position: LatLng(station.latitude, station.longitude),
            icon: customIcon,
            onTap: () {
              _showGasStationBottomSheet(station);
            },
          ),
        );
      }
    }
  }

  void _showGasStationBottomSheet(GasStation station) {
    setState(() {
      _selectedStation = station;
      _isLocationDetailsVisible = true;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.35,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with station name and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    station.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 24),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _isLocationDetailsVisible = false;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Logo and Prices
              Row(
                children: [
                  // Logo
                  Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(station.logoAsset),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Prices
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Blend: \$${station.blendPrice}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Diesel: \$${station.dieselPrice}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Status
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color:
                      _isGasStationOpen() ? Colors.green[50] : Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isGasStationOpen() ? Icons.check_circle : Icons.cancel,
                      color: _isGasStationOpen() ? Colors.green : Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isGasStationOpen() ? 'Open Now' : 'Closed',
                      style: TextStyle(
                        fontSize: 14,
                        color: _isGasStationOpen() ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Direction Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _drawPathLine(station);
                  },
                  icon: const Icon(Icons.directions, size: 24),
                  label: const Text(
                    'Get Directions',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool _isGasStationOpen() {
    // Add logic to determine if the gas station is open or closed
    // For now, we'll assume it's always open
    return true;
  }

  Widget _buildCurrentLocationBottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                const Text(
                  'Current Location',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Latitude: ${_currentLocation?.latitude.toStringAsFixed(6)}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Longitude: ${_currentLocation?.longitude.toStringAsFixed(6)}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'Address: $_locationName',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
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
    );
  }

  void _drawPathLine(GasStation station) {
    final PolylineId polylineId = const PolylineId('path_line');
    final Polyline polyline = Polyline(
      polylineId: polylineId,
      color: Colors.blue,
      width: 5,
      points: [
        _currentLocation!,
        LatLng(station.latitude, station.longitude),
      ],
    );

    setState(() {
      _polylines[polylineId] = polyline;
    });

    // Move the camera to show both locations
    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: _currentLocation!,
          southwest: LatLng(station.latitude, station.longitude),
        ),
        50.0, // Padding
      ),
    );
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
      _selectedStation = null; // Ensure no gas station is selected
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
                    polylines: Set<Polyline>.of(_polylines.values),
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
          ? _selectedStation == null
              ? _buildCurrentLocationBottomSheet()
              : null
          : null,
    );
  }
}
