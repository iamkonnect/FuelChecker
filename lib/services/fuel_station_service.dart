import 'dart:convert';
import 'package:http/http.dart' as http;

class FuelStationService {
  final String apiUrl = 'https://api.example.com/fuel_stations'; // Replace with actual API endpoint

  Future<List<FuelStation>> fetchFuelStations(double latitude, double longitude, String fuelType) async {
    final response = await http.get(Uri.parse('$apiUrl?lat=$latitude&lon=$longitude&type=$fuelType'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((station) => FuelStation.fromJson(station)).toList();
    } else {
      throw Exception('Failed to load fuel stations');
    }
  }
}

class FuelStation {
  final String name;
  final double latitude;
  final double longitude;
  final String logoUrl;
  final double price;

  FuelStation({required this.name, required this.latitude, required this.longitude, required this.logoUrl, required this.price});

  factory FuelStation.fromJson(Map<String, dynamic> json) {
    return FuelStation(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      logoUrl: json['logoUrl'],
      price: json['price'],
    );
  }
}
