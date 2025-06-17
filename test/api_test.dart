import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  group('API Tests', () {
    test('fetchAnalytics returns data on success', () async {
      final mockClient = MockClient((request) async {
        return http.Response(json.encode({'key': 'value'}), 200);
      });

      // Override the http client in api.dart with mockClient
      final result = await fetchAnalyticsWithClient(mockClient);
      expect(result, isA<Map<String, dynamic>>());
      expect(result['key'], 'value');
    });

    test('fetchAnalytics throws exception on failure', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      expect(() async => await fetchAnalyticsWithClient(mockClient), throwsException);
    });

    test('fetchFuelStations returns data on success', () async {
      final mockClient = MockClient((request) async {
        return http.Response(json.encode([{'station': 'A'}]), 200);
      });

      final result = await fetchFuelStationsWithClient(mockClient);
      expect(result, isA<List<dynamic>>());
      expect(result[0]['station'], 'A');
    });

    test('fetchFuelStations throws exception on failure', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      expect(() async => await fetchFuelStationsWithClient(mockClient), throwsException);
    });
  });
}

// Modified functions in api.dart to accept http.Client for testing
Future<Map<String, dynamic>> fetchAnalyticsWithClient(http.Client client) async {
  final response = await client.get(Uri.parse('http://localhost:3000/api/analytics'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load analytics data');
  }
}

Future<List<dynamic>> fetchFuelStationsWithClient(http.Client client) async {
  final response = await client.get(Uri.parse('http://localhost:3000/api/fuel_stations'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load fuel stations data');
  }
}
