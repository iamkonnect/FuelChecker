import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer' as developer;

import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/search_bar_with_filter_final.dart';
import '../widgets/map_controls.dart';
import '../models/fuel_station.dart';
import '../services/fuel_station_service.dart' as fuel_service;
import '../controllers/map_controller.dart';

class FuelMapScreen extends StatefulWidget {
  final String fuelType;

  const FuelMapScreen({Key? key, required this.fuelType}) : super(key: key);

  @override
  FuelMapScreenState createState() => FuelMapScreenState();
}

class FuelMapScreenState extends State<FuelMapScreen> {
  int _selectedIndex = 0;
  String _searchTerm = '';
  String _locationName = '';
  bool _isLocationDetailsVisible = false;
  LatLng? _location;
  late GoogleMapController mapController;
  Position? _currentPosition;
  List<FuelStation> _fuelStations = [];
  late Set<Marker> _markers = {};
  BitmapDescriptor? _userLocationIcon;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _loadUserLocationIcon();
    _getCurrentLocation();
    _fetchFuelStations();
  }

  Future<void> _loadUserLocationIcon() async {
    _userLocationIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/user_location.png',
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && 
          permission != LocationPermission.always) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
      _location = LatLng(position.latitude, position.longitude);
    });

    if (mapController != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_location!, 14.0),
      );
    }
  }

  Future<void> _fetchFuelStations() async {
    final service = fuel_service.FuelStationService();
    final stations = await service.fetchFuelStations(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      widget.fuelType,
    );

    setState(() {
      _fuelStations = stations.cast<FuelStation>();
    });
    await _createMarkers();
    setState(() {}); // Trigger rebuild with updated markers
  }

  Future<void> _createMarkers() async {
    final customIcon = await _getCustomMarkerIcon();
    final userIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/user_location.png',
    );

    final markers = _fuelStations.map((station) => Marker(
      markerId: MarkerId(station.id),
      position: LatLng(station.latitude, station.longitude),
      icon: customIcon,
      infoWindow: InfoWindow(
        title: station.name,
        snippet: '${station.location}\nPrice: \$${station.getFuelPrice(widget.fuelType).toStringAsFixed(2)}',
      ),
    )).toSet();

    if (_location != null) {
      markers.add(Marker(
        markerId: const MarkerId('user_location'),
        position: _location!,
        icon: userIcon,
      ));
    }

    setState(() {
      _markers = markers;
    });
  }

  Future<BitmapDescriptor> _getCustomMarkerIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/fuel_marker.png',
    );
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
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _location ?? const LatLng(-17.825, 31.033),
                zoom: 14.0,
              ),
              myLocationEnabled: false,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              markers: _markers,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                  _mapController.setController(controller);
                });
              },
              onCameraMove: (position) {
                _mapController.updateCameraPosition(position);
              },
              onTap: (location) {
                _getLocationName(location.latitude, location.longitude);
                setState(() {
                  _isLocationDetailsVisible = true;
                  _location = location;
                });
              },
            ),
          ),
          MapControls(
            controller: _mapController,
            onZoomIn: () => mapController.animateCamera(
              CameraUpdate.zoomIn(),
            ),
            onZoomOut: () => mapController.animateCamera(
              CameraUpdate.zoomOut(),
            ),
            onLocateUser: _getCurrentLocation,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onNavigationItemTapped,
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
      developer.log('Error getting coordinates: ${e.toString()}',
          name: 'FuelMapScreen');
    }
    return null;
  }

  Future<void> _getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        setState(() {
          _locationName = placemarks.first.name ?? '';
        });
      }
    } catch (e) {
      developer.log('Error fetching location name: ${e.toString()}',
          name: 'FuelMapScreen');
    }
  }
}
