import 'package:flutter/material.dart';
import '../models/fuel_station.dart';

class FavoriteProvider with ChangeNotifier {
  final List<FuelStation> _favorites = [];

  List<FuelStation> get favorites => _favorites;

  void addFavorite(FuelStation station) {
    _favorites.add(station);
    notifyListeners();
  }

  void removeFavorite(FuelStation station) {
    _favorites.remove(station);
    notifyListeners();
  }

  void populateDummyFavorites() {
    _favorites.addAll([
      FuelStation(name: 'Station A', location: '123 Main St'),
      FuelStation(name: 'Station B', location: '456 Elm St'),
      FuelStation(name: 'Station C', location: '789 Oak St'),
    ]);
    notifyListeners();
  }
}
