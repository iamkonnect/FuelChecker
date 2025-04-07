import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../models/fuel_gas_station.dart';

class NearbyService extends ChangeNotifier {
  List<GasStation> _nearbyStations = [];
  Position? _currentPosition;

  List<GasStation> get nearbyStations => _nearbyStations;

  void updateNearbyStations(
      List<GasStation> stations, Position? position, double radius) {
    _currentPosition = position;

    // Filter stations by radius
    _nearbyStations = stations.where((station) {
      if (_currentPosition == null) return false;
      final distance = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        station.latitude,
        station.longitude,
      );
      return distance <= radius;
    }).toList()
      ..sort((a, b) {
        final distA = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          a.latitude,
          a.longitude,
        );
        final distB = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          b.latitude,
          b.longitude,
        );
        return distA.compareTo(distB);
      });

    notifyListeners();
  }
}
