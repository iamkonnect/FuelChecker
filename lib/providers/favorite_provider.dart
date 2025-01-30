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
      FuelStation(
        name: 'TotalEnergies Service Station Coropark (Pvt) Ltd',
        location: '123 Main St',
        contact: '077 293 8722',
        logo: 'assets/images/Total Energies.png',
        fuelPrices: {
          'diesel': 1.20,
          'petrol': 1.50,
        },
      ),
      FuelStation(
        name: 'ZUVA Greendale',
        location: '456 Elm St',
        contact: '078 246 7409',
        logo: 'assets/images/zuva energy.png',
        fuelPrices: {
          'diesel': 1.25,
          'petrol': 1.55,
        },
      ),
      FuelStation(
        name: 'Energy Park',
        location: '789 Oak St',
        contact: '079 123 4567',
        logo: 'assets/images/energy park.png',
        fuelPrices: {
          'diesel': 1.30,
          'petrol': 1.60,
        },
      ),
    ]);
    notifyListeners();
  }
}
