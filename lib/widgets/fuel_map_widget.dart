import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../services/fuel_station_service.dart'; // Ensure this path is correct

class CustomMarker extends StatelessWidget {
  final String name;
  final String logoUrl;

  const CustomMarker({Key? key, required this.name, required this.logoUrl}) : super(key: key);

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
  @override
  _FuelMapWidgetState createState() => _FuelMapWidgetState();
}

class _FuelMapWidgetState extends State<FuelMapWidget> {
  MapController _mapController = MapController();
  Position? _currentPosition;
  List<FuelStation> _fuelStations = [];
  List<LatLng> _routePoints = []; // To store route points

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    );
    _mapController.move(
      LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      13,
    );
    await _fetchFuelStations();
    setState(() {});
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
      appBar: AppBar(title: Text('Fuel Map')),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                crs: const Epsg3857(), // Updated CRS
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: _fuelStations.map((station) {
                    return Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(station.latitude, station.longitude),
                      child: CustomMarker(
                        name: station.name,
                        logoUrl: station.logoUrl,
                      ),
                    );
                  }).toList(),
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
