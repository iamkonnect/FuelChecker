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
}
