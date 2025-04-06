import 'package:flutter/foundation.dart';
import '../models/fuel_gas_station.dart';

class NearbyService extends ChangeNotifier {
  List<GasStation> _nearbyStations = [];

  List<GasStation> get nearbyStations => _nearbyStations;

  void updateNearbyStations(List<GasStation> stations) {
    _nearbyStations = stations;
    notifyListeners();
  }
}
