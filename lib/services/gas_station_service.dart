import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../models/fuel_gas_station.dart';

class GasStationService {
  final Position currentPosition;
  final List<Map<String, dynamic>> localStations;
  static const String _functionsBaseUrl =
      'https://us-central1-bahati-4911e.cloudfunctions.net';

  GasStationService({
    required this.currentPosition,
    required this.localStations,
  });

  Future<List<GasStation>> getCombinedStations(double radius) async {
    try {
      final cloudStations = await _fetchFromCloudFunction(radius);
      final enrichedStations = _enrichWithLocalData(cloudStations);
      return _mergeWithLocalStations(enrichedStations);
    } catch (e) {
      print('Error fetching stations: $e');
      return _fallbackToLocalStations();
    }
  }

  Future<List<GasStation>> _fetchFromCloudFunction(double radius) async {
    try {
      final url = Uri.parse('$_functionsBaseUrl/getNearbyGasStations'
          '?lat=${currentPosition.latitude}'
          '&lng=${currentPosition.longitude}'
          '&radius=$radius');

      final response = await http.get(url);
      if (response.statusCode != 200) return [];

      final data = json.decode(response.body);
      return _processCloudResponse(data);
    } catch (e) {
      print('Cloud function error: $e');
      return [];
    }
  }

  List<GasStation> _processCloudResponse(Map<String, dynamic> responseData) {
    return (responseData['results'] as List)
        .map((result) => _convertCloudResult(result))
        .toList();
  }

  GasStation _convertCloudResult(Map<String, dynamic> result) {
    return GasStation(
      id: result['place_id'] ?? 'N/A',
      name: result['name'] ?? 'Unknown Station',
      town: result['vicinity'] ?? 'Unknown Area',
      latitude: (result['geometry']['location']['lat'] as num).toDouble(),
      longitude: (result['geometry']['location']['lng'] as num).toDouble(),
      blendPrice: _getPriceFromLocalData(result['name'], 'blend'),
      dieselPrice: _getPriceFromLocalData(result['name'], 'diesel'),
      logoAsset: _getLocalAsset(result['name']),
      stationIcon: _getStationIcon(result),
      // rating: (result['rating'] ?? 0.0).toDouble(),
    );
  }

  String _getStationIcon(Map<String, dynamic> result) {
    if (result['photos'] != null && result['photos'].isNotEmpty) {
      return 'https://maps.googleapis.com/maps/api/place/photo'
          '?maxwidth=400'
          '&photoreference=${result['photos'][0]['photo_reference']}';
    }
    return 'https://fonts.gstatic.com/s/i/materialicons/local_gas_station/v12/24px.svg';
  }

  double _getPriceFromLocalData(String stationName, String fuelType) {
    final localMatch = localStations.firstWhere(
      (local) => _isSameStation(
          local,
          GasStation(
            id: '',
            name: stationName,
            town: '',
            latitude: 0,
            longitude: 0,
            blendPrice: 0,
            dieselPrice: 0,
            logoAsset: '',
            stationIcon: '',
          )),
      orElse: () => <String, dynamic>{},
    );

    return localMatch.isNotEmpty
        ? (localMatch['${fuelType}Price'] ?? _getDefaultPrice(fuelType))
            .toDouble()
        : _getDefaultPrice(fuelType);
  }

  double _getDefaultPrice(String fuelType) => fuelType == 'blend' ? 1.25 : 1.15;

  List<GasStation> _enrichWithLocalData(List<GasStation> cloudStations) {
    return cloudStations.map((cloudStation) {
      final localMatch = localStations.firstWhere(
        (local) => _isSameStation(local, cloudStation),
        orElse: () => <String, dynamic>{},
      );

      return localMatch.isNotEmpty
          ? cloudStation.copyWith(
              blendPrice: localMatch['blendPrice'] ?? cloudStation.blendPrice,
              dieselPrice:
                  localMatch['dieselPrice'] ?? cloudStation.dieselPrice,
              logoAsset: localMatch['logoAsset'] ?? cloudStation.logoAsset,
            )
          : cloudStation;
    }).toList();
  }

  List<GasStation> _mergeWithLocalStations(List<GasStation> cloudStations) {
    final localGasStations = localStations
        .map((s) => GasStation.fromMap(s['id'], s))
        .where((local) =>
            !cloudStations.any((cloud) => _isSameStation(cloud, local)))
        .toList();

    return [...cloudStations, ...localGasStations];
  }

  List<GasStation> _fallbackToLocalStations() {
    return localStations
        .map((s) => GasStation.fromMap(s['id'], s))
        .where((station) =>
            Geolocator.distanceBetween(
              currentPosition.latitude,
              currentPosition.longitude,
              station.latitude,
              station.longitude,
            ) <=
            5000)
        .toList();
  }

  bool _isSameStation(dynamic stationA, GasStation stationB) {
    if (stationA is Map<String, dynamic>) {
      return _compareStationData(stationA, stationB);
    }
    return _compareStationObjects(stationA, stationB);
  }

  bool _compareStationData(Map<String, dynamic> stationA, GasStation stationB) {
    final distance = Geolocator.distanceBetween(
      stationA['latitude']?.toDouble() ?? 0,
      stationA['longitude']?.toDouble() ?? 0,
      stationB.latitude,
      stationB.longitude,
    );

    final nameSimilarity = _stringSimilarity(
      stationA['name'] ?? '',
      stationB.name,
    );

    return distance < 50 || nameSimilarity > 0.8;
  }

  bool _compareStationObjects(GasStation stationA, GasStation stationB) {
    final distance = Geolocator.distanceBetween(
      stationA.latitude,
      stationA.longitude,
      stationB.latitude,
      stationB.longitude,
    );

    final nameSimilarity = _stringSimilarity(stationA.name, stationB.name);
    return distance < 50 || nameSimilarity > 0.8;
  }

  double _stringSimilarity(String a, String b) {
    final aWords = a.toLowerCase().split(RegExp(r'\W+'));
    final bWords = b.toLowerCase().split(RegExp(r'\W+'));
    final commonWords = aWords.toSet().intersection(bWords.toSet()).length;
    return commonWords / aWords.length;
  }

  String _getLocalAsset(String stationName) {
    const brandAssets = {
      'shell': 'assets/logos/shell.png',
      'bp': 'assets/logos/bp.png',
      'puma': 'assets/logos/puma.png',
      'camel': 'assets/logos/camel.png',
    };

    final cleanedName = stationName.toLowerCase();
    return brandAssets.entries
        .firstWhere(
          (entry) => cleanedName.contains(entry.key),
          orElse: () => const MapEntry('default',
              'https://fonts.gstatic.com/s/i/materialicons/local_gas_station/v12/24px.svg'),
        )
        .value;
  }
}

// // lib/services/gas_station_service.dart
// //https://us-central1-bahati-4911e.cloudfunctions.net
// import 'dart:convert';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import '../models/fuel_gas_station.dart';

// class GasStationService {
//   final Position currentPosition;
//   final List<Map<String, dynamic>> localStations;
//   static const String _apiKey = 'YOUR_GOOGLE_API_KEY';
//   static const String _placesBaseUrl =
//       'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
//   static const String _placesDetailsUrl =
//       'https://maps.googleapis.com/maps/api/place/details/json';

//   GasStationService({
//     required this.currentPosition,
//     required this.localStations,
//   });

//   Future<List<GasStation>> getCombinedStations(double radius) async {
//     try {
//       final googleStations = await _getAllGooglePlacesStations(radius);
//       final enrichedStations = await _enrichWithLocalData(googleStations);
//       return _mergeWithLocalStations(enrichedStations);
//     } catch (e) {
//       print('Error fetching stations: $e');
//       return localStations.map((s) => GasStation.fromMap(s['id'], s)).toList();
//     }
//   }

//   Future<List<GasStation>> _getAllGooglePlacesStations(double radius) async {
//     List<Map<String, dynamic>> allResults = [];
//     String? nextPageToken;

//     do {
//       final url = Uri.parse('$_placesBaseUrl?'
//           'location=${currentPosition.latitude},${currentPosition.longitude}'
//           '&radius=$radius'
//           '&type=gas_station'
//           '&key=$_apiKey'
//           '${nextPageToken != null ? '&pagetoken=$nextPageToken' : ''}');

//       final response = await http.get(url);
//       if (response.statusCode != 200) break;

//       final data = json.decode(response.body);
//       allResults.addAll(List<Map<String, dynamic>>.from(data['results']));
//       nextPageToken = data['next_page_token'];

//       if (nextPageToken != null) await Future.delayed(Duration(seconds: 2));
//     } while (nextPageToken != null);

//     return await Future.wait(allResults.map(_convertPlaceToGasStation));
//   }

//   Future<GasStation> _convertPlaceToGasStation(
//       Map<String, dynamic> place) async {
//     final details = await _getPlaceDetails(place['place_id']);

//     return GasStation(
//       id: place['place_id'],
//       name: place['name'],
//       town: place['vicinity'] ?? 'Unknown Area',
//       latitude: place['geometry']['location']['lat'],
//       longitude: place['geometry']['location']['lng'],
//       blendPrice: _getPriceFromDetails(details, 'blend'),
//       dieselPrice: _getPriceFromDetails(details, 'diesel'),
//       logoAsset: _getLocalAsset(place['name']),
//       stationIcon: place['icon'] ??
//           'https://fonts.gstatic.com/s/i/materialicons/local_gas_station/v12/24px.svg',
//       // openingHours: details['opening_hours']?['weekday_text'] ?? [],
//       // rating: details['rating']?.toDouble() ?? 0.0,
//     );
//   }

//   Future<Map<String, dynamic>> _getPlaceDetails(String placeId) async {
//     final response = await http
//         .get(Uri.parse('$_placesDetailsUrl?place_id=$placeId&key=$_apiKey'));
//     return response.statusCode == 200
//         ? json.decode(response.body)['result']
//         : {};
//   }

//   double _getPriceFromDetails(Map<String, dynamic> details, String fuelType) {
//     final prices = {
//       'blend': 1.25,
//       'diesel': 1.15,
//     };

//     // Implement your price extraction logic from details
//     // This could parse user reviews or use other metadata
//     return prices[fuelType]!;
//   }

//   String _getLocalAsset(String stationName) {
//     const brandAssets = {
//       'shell':
//           'https://fonts.gstatic.com/s/i/materialicons/local_gas_station/v12/24px.svg',
//       'bp':
//           'https://fonts.gstatic.com/s/i/materialicons/local_gas_station/v12/24px.svg',
//       // Add more brand mappings
//     };

//     return brandAssets.entries
//         .firstWhere(
//           (entry) => stationName.toLowerCase().contains(entry.key),
//           orElse: () => MapEntry('default',
//               'https://fonts.gstatic.com/s/i/materialicons/local_gas_station/v12/24px.svg'),
//         )
//         .value;
//   }

//   List<GasStation> _enrichWithLocalData(List<GasStation> googleStations) {
//     return googleStations.map((gStation) {
//       final localMatch = localStations.firstWhere(
//         (local) => _isSameStation(local, gStation),
//         orElse: () => {},
//       );

//       return localMatch.isNotEmpty
//           ? gStation.copyWith(
//               blendPrice: localMatch['blendPrice'] ?? gStation.blendPrice,
//               dieselPrice: localMatch['dieselPrice'] ?? gStation.dieselPrice,
//               logoAsset: localMatch['logoAsset'] ?? gStation.logoAsset,
//             )
//           : gStation;
//     }).toList();
//   }

//   List<GasStation> _mergeWithLocalStations(List<GasStation> googleStations) {
//     final localGasStations = this
//         .localStations
//         .map((s) => GasStation.fromMap(s['id'], s))
//         .where((local) => !googleStations.any((g) => _isSameStation(g, local)))
//         .toList();

//     return [...googleStations, ...localGasStations];
//   }

//   bool _isSameStation(dynamic stationA, GasStation stationB) {
//     final distance = Geolocator.distanceBetween(
//       stationA['latitude'] ?? stationA.latitude,
//       stationA['longitude'] ?? stationA.longitude,
//       stationB.latitude,
//       stationB.longitude,
//     );

//     final nameSimilarity = _stringSimilarity(
//       stationA['name'] ?? stationA.name,
//       stationB.name,
//     );

//     return distance < 50 || nameSimilarity > 0.8;
//   }

//   double _stringSimilarity(String a, String b) {
//     final aWords = a.toLowerCase().split(' ');
//     final bWords = b.toLowerCase().split(' ');
//     final commonWords = aWords.where((w) => bWords.contains(w)).length;
//     return commonWords / aWords.length;
//   }
// }
