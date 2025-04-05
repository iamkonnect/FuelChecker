// lib/services/gas_station_service.dart
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../models/fuel_gas_station.dart';

class GasStationService {
  final Position currentPosition;
  final List<Map<String, dynamic>> localStations;
  static const String _apiKey = 'DfTXLcqP50wIO63JO2xG3ryZKes=';
  static const String _placesBaseUrl =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

  GasStationService({
    required this.currentPosition,
    required this.localStations,
  });

  Future<List<GasStation>> getCombinedStations(double radius) async {
    final List<GasStation> combinedStations = [];

    try {
      // Get Google Places stations
      final googleStations = await _getGooglePlacesStations(radius);

      // Merge with local data
      for (var googleStation in googleStations) {
        final localMatch = localStations.firstWhere(
          (local) => _isSameStation(local, googleStation),
          orElse: () => {},
        );

        combinedStations.add(GasStation(
          id: googleStation['place_id'],
          name: googleStation['name'],
          town:
              localMatch['town'] ?? googleStation['vicinity'] ?? 'Unknown Area',
          latitude: googleStation['geometry']['location']['lat'],
          longitude: googleStation['geometry']['location']['lng'],
          blendPrice: localMatch['blendPrice'] ?? 1.25,
          dieselPrice: localMatch['dieselPrice'] ?? 1.15,
          logoAsset: localMatch['logoAsset'] ?? 'assets/Logo/pumaBR.png',
          stationIcon: localMatch['stationIcon'] ??
              'https://fonts.gstatic.com/s/i/materialicons/local_gas_station/v12/24px.svg',
        ));
      }

      // Add local stations not found in Google Places results
      final googleIds = googleStations.map((g) => g['place_id']).toList();
      for (var localStation in localStations) {
        if (!googleIds.contains(localStation['id'])) {
          combinedStations
              .add(GasStation.fromMap(localStation['id'], localStation));
        }
      }
    } catch (e) {
      print('Error combining stations: $e');
      // Fallback to local stations only
      return localStations.map((s) => GasStation.fromMap(s['id'], s)).toList();
    }

    return combinedStations;
  }

  bool _isSameStation(Map<String, dynamic> local, Map<String, dynamic> google) {
    final distance = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      local['latitude'],
      local['longitude'],
    );
    return distance < 100;
  }

  Future<List<Map<String, dynamic>>> _getGooglePlacesStations(
      double radius) async {
    final url = Uri.parse('$_placesBaseUrl?'
        'location=${currentPosition.latitude},${currentPosition.longitude}'
        '&radius=$radius'
        '&type=gas_station'
        '&key=$_apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      }
      throw Exception('Failed to load places: ${response.statusCode}');
    } catch (e) {
      print('Google Places API error: $e');
      return [];
    }
  }
}
