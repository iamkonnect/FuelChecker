// lib/services/favorites_service.dart
import 'package:flutter/foundation.dart';
import '../models/fuel_gas_station.dart';

class FavoritesService with ChangeNotifier {
  final List<GasStation> _favorites = [];

  List<GasStation> get favorites => _favorites;

  void toggleFavorite(GasStation station) {
    final index = _favorites.indexWhere((s) => s.id == station.id);

    if (index != -1) {
      _favorites.removeAt(index);
      station.isFavorite = false;
    } else {
      _favorites.add(station.copyWith(isFavorite: true));
      station.isFavorite = true;
    }
    notifyListeners();
  }

  bool isFavorite(GasStation station) =>
      _favorites.any((s) => s.id == station.id);
}
