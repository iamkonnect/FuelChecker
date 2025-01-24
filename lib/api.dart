import 'dart:convert';
import 'package:http/http.dart' as http;

// Fetch analytics data
Future<Map<String, dynamic>> fetchAnalytics() async {
  final response = await http.get(Uri.parse('http://localhost:3000/api/analytics'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load analytics data');
  }
}

// Fetch fuel stations data
Future<List<dynamic>> fetchFuelStations() async {
  final response = await http.get(Uri.parse('http://localhost:3000/api/fuel_stations'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load fuel stations data');
  }
}
