import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
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
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      final place = placemarks.firstOrNull;
      if (place == null) {
        setState(() => _locationName = 'Unknown Location');
        return;
      }

      final street = _cleanString(place.street) ?? 'Unnamed Road';
      final locality = _cleanString(place.locality) ?? 'Unknown Area';
      final country = _cleanString(place.country) ?? 'Unknown Country';

      setState(() {
        _locationName = '$street, $locality, $country'
            .replaceAll(RegExp(r' ,'), ',') // Remove awkward spaces
            .replaceAll(', ,', ',');
      });
    } catch (e, stack) {
      print('Geocoding Error: ${e.toString()}\n$stack');
      setState(() => _locationName = 'Location details unavailable');
    }
  }

  String? _cleanString(String? input) {
    return input?.trim().isEmpty ?? true ? null : input!.trim();
  }

  void _addFuelStationMarkers() async {
    _markers.clear();
    for (final station in _nearbyStations) {
      if (_searchTerm.isEmpty ||
          station.name.toLowerCase().contains(_searchTerm.toLowerCase())) {
        final BitmapDescriptor customIcon =
            await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(50, 50)),
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
                    width: 40,
                    height: 48,
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
                    Navigator.pop(context);
                    setState(() {
                      _isLocationDetailsVisible = false;
                    });
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

  void _drawPathLine(GasStation station) async {
    if (_currentLocation == null) return;

    try {
      final start = _currentLocation!;
      final end = LatLng(station.latitude, station.longitude);

      print('''Requesting directions:
    From: ${start.latitude},${start.longitude}
    To: ${end.latitude},${end.longitude}''');

      final response = await DirectionsAPI.getDirections(start, end);
      print('Raw API Response: ${jsonEncode(response)}');

      // Validate response structure
      final routes = response['routes'] as List<dynamic>?;
      final overviewPolyline =
          routes?.firstOrNull?['overview_polyline'] as Map<String, dynamic>?;
      final encodedPolyline = overviewPolyline?['points'] as String?;

      if (encodedPolyline == null || encodedPolyline.isEmpty) {
        throw Exception('No valid polyline found in response');
      }

      // Decode and validate coordinates
      final coordinates = DirectionsAPI.decodePolyline(encodedPolyline);
      print('Decoded ${coordinates.length} points');

      if (coordinates.isEmpty) {
        throw Exception('Decoded polyline is empty');
      }

      // Create unique polyline ID
      final polylineId =
          PolylineId('${station.id}_${DateTime.now().millisecondsSinceEpoch}');

      setState(() {
        _polylines
          ..clear()
          ..putIfAbsent(
              polylineId,
              () => Polyline(
                    polylineId: polylineId,
                    color: Colors.red, // More visible color
                    width: 4,
                    points: coordinates,
                  ));
      });

      // Calculate bounds with padding
      final bounds = _boundsFromLatLngList([start, end, ...coordinates]);
      print('Camera Bounds: NE ${bounds.northeast}, SW ${bounds.southwest}');

      // Animate camera with padding
      await _mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 100),
      );

      // Force redraw
      if (mounted) setState(() {});
    } catch (e, stack) {
      print('''Route Error:
    $e
    $stack''');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Failed to draw route: ${e.toString().split(':').last.trim()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> points) {
    assert(points.isNotEmpty, "Can't calculate bounds for empty points list");

    var minLat = points.first.latitude;
    var maxLat = points.first.latitude;
    var minLng = points.first.longitude;
    var maxLng = points.first.longitude;

    for (final point in points) {
      minLat = minLat < point.latitude ? minLat : point.latitude;
      maxLat = maxLat > point.latitude ? maxLat : point.latitude;
      minLng = minLng < point.longitude ? minLng : point.longitude;
      maxLng = maxLng > point.longitude ? maxLng : point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
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
                    // Add this in your GoogleMap widget
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                      print('Map controller ready');
                      // Add initial camera position if needed
                      if (_currentLocation != null) {
                        controller.animateCamera(
                          CameraUpdate.newLatLngZoom(_currentLocation!, 14),
                        );
                      }
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

class DirectionsAPI {
  // Replace with your actual Firebase project ID
  static const String _baseUrl =
      'https://us-central1-bahati-4911e.cloudfunctions.net/getDirections';

  static Future<Map<String, dynamic>> getDirections(
      LatLng origin, LatLng destination) async {
    try {
      final Uri url =
          Uri.parse('$_baseUrl?origin=${origin.latitude},${origin.longitude}'
              '&destination=${destination.latitude},${destination.longitude}');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Directions API Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Directions API Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Directions Error: $e');
      rethrow;
    }
  }

  /// Decodes a Google Maps encoded polyline into a list of LatLng points.
  static List<LatLng> decodePolyline(String encoded) {
    if (encoded.isEmpty) return [];

    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      // Latitude
      int shift = 0, result = 0;
      int b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      // Longitude
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }

    return points;
  }
}
