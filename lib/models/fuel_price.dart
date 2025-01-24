import 'package:geolocator/geolocator.dart';

class FuelPrice {
  final double pricePerLiter;
  final double liters;

  FuelPrice({required this.pricePerLiter, required this.liters});

  double calculateTotal() {
    return pricePerLiter * liters;
  }
}

class FuelStation {
  final String name;
  final String location;
  final double latitude;
  final double longitude;
  final double blendESPrice;
  final double dieselPrice;

  FuelStation({
    required this.name,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.blendESPrice,
    required this.dieselPrice,
  });

  // Calculate distance from current location in kilometers
  double distanceFrom(double lat, double lng) {
    return Geolocator.distanceBetween(
      latitude,
      longitude,
      lat,
      lng,
    ) / 1000; // Convert meters to kilometers
  }
}

// Helper function to filter stations within 5km radius
List<FuelStation> getNearbyStations(List<FuelStation> stations, double lat, double lng) {
  return stations.where((station) => station.distanceFrom(lat, lng) <= 5).toList();
}
