import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/fuel_station.dart';
import '../api.dart';

class FuelStationService {
  Future<List<FuelStation>> fetchFuelStations(double latitude, double longitude, String fuelType) async {
    try {
      final stationsData = await fetchFuelStations(latitude, longitude, fuelType);
      List jsonResponse = json.decode(stationsData.toString());
      
      // Filter stations by location and fuel type
      return jsonResponse.map((station) => FuelStation.fromJson(station))
        .where((station) => 
          station.isWithinRadius(latitude, longitude, 5) && // 5km radius
          station.fuelPrices.containsKey(fuelType))
        .toList();
    } catch (e) {
      throw Exception('Failed to load fuel stations: $e');
    }
  }

  Future<List<FuelStation>> fetchNearbyStations(double latitude, double longitude, double radiusKm) async {
    try {
      final stationsData = await fetchFuelStations(latitude, longitude, '');
      List jsonResponse = json.decode(stationsData.toString());
      
      return jsonResponse.map((station) => FuelStation.fromJson(station))
        .where((station) => station.isWithinRadius(latitude, longitude, radiusKm))
        .toList();
    } catch (e) {
      throw Exception('Failed to load nearby stations: $e');
    }
  }
}
