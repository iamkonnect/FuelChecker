import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';


class FuelStationCoordinates {
  final Logger logger = Logger();

  final String apiKey = 'YOUR_GEOCODING_API_KEY'; // Replace with your actual API key
  final String apiUrl = 'https://api.geocoding.com/geocode'; // Replace with actual geocoding API endpoint

  Future<Map<String, LatLng>> fetchCoordinates(List<String> towns) async {
    Map<String, LatLng> coordinates = {};

    for (String town in towns) {
      final response = await http.get(Uri.parse('$apiUrl?address=$town&key=$apiKey'));

      logger.i('API Response for $town: ${response.body}'); // Log the API response


      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['results'].isNotEmpty) {
          var lat = jsonResponse['results'][0]['geometry']['location']['lat'];
          var lng = jsonResponse['results'][0]['geometry']['location']['lng'];
          coordinates[town] = LatLng(lat, lng);
        } else {
          logger.w('No results found for $town');

        }
      } else {
        throw Exception('Failed to load coordinates for $town');
      }
    }

    return coordinates;
  }
}

class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);
}
