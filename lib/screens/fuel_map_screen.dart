import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../local_gas_stations.dart';
import '../models/fuel_gas_station.dart';
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
  double _searchRadius = 5000;
  late FavoriteService _favoriteService;

  @override
  void initState() {
    super.initState();
    _favoriteService = FavoriteService();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _favoriteService.initialize();
    _fuelStations = localGasStations.map((station) {
      return GasStation.fromMap(station['id'], station)
        ..isFavorite = _favoriteService.isFavorite(station['id']);
    }).toList();
    _getCurrentLocation();
  }

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
        _updateNearbyStations(position.latitude, position.longitude);
        _addFuelStationMarkers();
        _getLocationName(position.latitude, position.longitude);
      });
    }
  }

  Future<void> _updateNearbyStations(double lat, double lng) async {
    final googleStations = await _fetchGooglePlacesStations(lat, lng);
    final mergedStations = _mergeStations(_fuelStations, googleStations);

    setState(() {
      _nearbyStations =
          getNearbyStations(mergedStations, lat, lng, _searchRadius);
    });
  }

  Future<List<GasStation>> _fetchGooglePlacesStations(
      double lat, double lng) async {
    const radius = 5000;
    const apiKey = 'YOUR_GOOGLE_API_KEY';
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=$radius&type=gas_station&key=$apiKey',
    );

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      return (data['results'] as List).map((place) {
        return GasStation(
          id: place['place_id'],
          name: place['name'],
          latitude: place['geometry']['location']['lat'],
          longitude: place['geometry']['location']['lng'],
          blendPrice: 0.0,
          dieselPrice: 0.0,
          logoAsset: 'assets/Logo/pumaBR.png',
          town: 'Unknown',
          stationIcon:
              "https://fonts.gstatic.com/s/i/materialicons/local_gas_station/v12/24px.svg",
          isFavorite: _favoriteService.isFavorite(place['place_id']),
        );
      }).toList();
    } catch (e) {
      print('Google Places API Error: $e');
      return [];
    }
  }

  List<GasStation> _mergeStations(
      List<GasStation> local, List<GasStation> google) {
    final merged = <GasStation>[...local];
    final localIds = local.map((s) => s.id).toSet();
    merged.addAll(google.where((g) => !localIds.contains(g.id)));
    return merged;
  }

  double _haversineDistance(
      double lat1, double lng1, double lat2, double lng2) {
    const R = 6371e3; // Earth radius in meters
    final lat1Rad = _toRadians(lat1);
    final lat2Rad = _toRadians(lat2);
    final deltaLat = _toRadians(lat2 - lat1);
    final deltaLng = _toRadians(lng2 - lng1);

    final a = math.sin(deltaLat / 2) * math.sin(deltaLat / 2) +
        math.cos(lat1Rad) *
            math.cos(lat2Rad) *
            math.sin(deltaLng / 2) *
            math.sin(deltaLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return R * c;
  }

  double _toRadians(double degrees) => degrees * math.pi / 180;

  List<GasStation> getNearbyStations(
    List<GasStation> stations,
    double lat,
    double lng,
    double radius,
  ) {
    return stations.where((station) {
      final distance =
          _haversineDistance(lat, lng, station.latitude, station.longitude);
      return distance <= radius;
    }).toList();
  }

  Future<void> _getLocationName(double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      final place = placemarks.first;

      setState(() {
        _locationName = [place.street, place.locality, place.country]
            .where((part) => part?.isNotEmpty ?? false)
            .join(', ');
      });
    } catch (e, stack) {
      print('Geocoding Error: $e\n$stack');
      setState(() => _locationName = 'Location details unavailable');
    }
  }

  void _addFuelStationMarkers() async {
    _markers.clear();
    for (final station in _nearbyStations) {
      if (_searchTerm.isEmpty ||
          station.name.toLowerCase().contains(_searchTerm.toLowerCase())) {
        final customIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(50, 50)),
          station.logoAsset,
        );

        _markers.add(
          Marker(
            markerId: MarkerId(station.id),
            position: LatLng(station.latitude, station.longitude),
            icon: customIcon,
            onTap: () => _showGasStationBottomSheet(station),
          ),
        );
      }
    }
    setState(() {});
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
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(station.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Blend: \$${station.blendPrice}'),
                      Text('Diesel: \$${station.dieselPrice}'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
                    Text(_isGasStationOpen() ? 'Open Now' : 'Closed'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _drawPathLine(station);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.directions),
                      label: const Text('Directions'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _toggleFavorite(station),
                      icon: Icon(
                        station.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      label:
                          Text(station.isFavorite ? 'Favorited' : 'Favorite'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleFavorite(GasStation station) {
    setState(() {
      station.isFavorite = !station.isFavorite;
      _favoriteService.toggleFavorite(station.id);
    });
  }

  void _showRadiusFilter() async {
    final newRadius = await showDialog<double>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Search Radius'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${(_searchRadius / 1000).toStringAsFixed(1)} km'),
              Slider(
                value: _searchRadius,
                min: 1000,
                max: 10000,
                divisions: 9,
                label: '${(_searchRadius / 1000).round()} km',
                onChanged: (value) => setState(() => _searchRadius = value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, _searchRadius),
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );

    if (newRadius != null && _currentLocation != null) {
      setState(() {
        _searchRadius = newRadius;
        _updateNearbyStations(
            _currentLocation!.latitude, _currentLocation!.longitude);
      });
    }
  }

  void _drawPathLine(GasStation station) async {
    if (_currentLocation == null) return;

    try {
      final directions = await DirectionsAPI.getDirections(
        _currentLocation!,
        LatLng(station.latitude, station.longitude),
      );

      final points = directions['routes'][0]['overview_polyline']['points'];
      final coordinates = DirectionsAPI.decodePolyline(points);

      setState(() {
        _polylines.clear();
        _polylines[PolylineId(station.id)] = Polyline(
          polylineId: PolylineId(station.id),
          color: Colors.blue,
          width: 4,
          points: coordinates,
        );
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(
          _boundsFromLatLngList([_currentLocation!, ...coordinates]),
          100,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Route error: ${e.toString()}')),
      );
    }
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> points) {
    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (final point in points) {
      minLat = math.min(minLat, point.latitude);
      maxLat = math.max(maxLat, point.latitude);
      minLng = math.min(minLng, point.longitude);
      maxLng = math.max(maxLng, point.longitude);
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  bool _isGasStationOpen() => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Map'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/fuel_type'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showRadiusFilter,
            tooltip: 'Filter by radius',
          ),
          IconButton(
            icon: const Icon(Icons.near_me),
            onPressed: () => Navigator.pushNamed(context, '/nearby'),
            tooltip: 'Nearby stations',
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
                    onMapCreated: (controller) => _mapController = controller,
                  ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() => _selectedIndex = index);
          // Navigation logic here
        },
      ),
      bottomSheet: _isLocationDetailsVisible && _selectedStation == null
          ? _buildCurrentLocationBottomSheet()
          : null,
    );
  }

  Widget _buildCurrentLocationBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Current Location',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text('Lat: ${_currentLocation!.latitude.toStringAsFixed(6)}'),
          Text('Lng: ${_currentLocation!.longitude.toStringAsFixed(6)}'),
          const SizedBox(height: 10),
          Text(_locationName, textAlign: TextAlign.center),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: _hideLocationDetails,
          ),
        ],
      ),
    );
  }

  Future<LatLng?> getCoordinates(String location) async {
    try {
      final locations = await locationFromAddress(location);
      return locations.isNotEmpty
          ? LatLng(locations.first.latitude, locations.first.longitude)
          : null;
    } catch (e) {
      print('Geocoding error: $e');
      return null;
    }
  }

  void _hideLocationDetails() =>
      setState(() => _isLocationDetailsVisible = false);
}

class DirectionsAPI {
  static const _baseUrl = 'YOUR_DIRECTIONS_API_ENDPOINT';

  static Future<Map<String, dynamic>> getDirections(
      LatLng origin, LatLng destination) async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}'));
      return json.decode(response.body);
    } catch (e) {
      throw Exception('Directions request failed: $e');
    }
  }

  static List<LatLng> decodePolyline(String encoded) {
    // Existing decodePolyline implementation
  }
}

class FavoriteService {
  static const _key = 'favorites';
  late SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool isFavorite(String id) =>
      _prefs.getStringList(_key)?.contains(id) ?? false;

  Future<void> toggleFavorite(String id) async {
    final favorites = _prefs.getStringList(_key) ?? [];
    favorites.contains(id) ? favorites.remove(id) : favorites.add(id);
    await _prefs.setStringList(_key, favorites);
  }
}
