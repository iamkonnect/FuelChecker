import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_directions/flutter_map_directions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../services/fuel_station_service.dart'; // Ensure this path is correct

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
    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _mapController.move(LatLng(_currentPosition!.latitude, _currentPosition!.longitude), 13);
    await _fetchFuelStations();
    setState(() {});
  }

  Future<void> _fetchFuelStations() async {
    FuelStationService service = FuelStationService();
    _fuelStations = await service.fetchFuelStations(_currentPosition!.latitude, _currentPosition!.longitude, 'your_fuel_type'); // Replace with actual fuel type
    setState(() {});
  }

  // Method to calculate and display the route
  void _calculateRoute(LatLng from, LatLng to) {
    // Example logic to calculate route points
    _routePoints = [from, to]; // Replace with actual route calculation logic
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
                center: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: _fuelStations.map((station) {
                    return Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(station.latitude, station.longitude),
                      builder: (ctx) => Container(
                        child: Column(
                          children: [
                            Image.network(station.logoUrl, width: 40, height: 40),
                            Text(station.name),
                            Text('\$${station.price.toStringAsFixed(2)}'),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                PolylineLayerOptions(
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