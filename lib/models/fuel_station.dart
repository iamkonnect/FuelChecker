import 'dart:math' as math;
import 'package:geolocator/geolocator.dart';

class FuelStation {

  final String id;
  final String name;
  final String location;
  final String contact;
  final String logo;
  final double latitude;
  final double longitude;
  final Map<String, double> fuelPrices; // Fuel type as key and price as value

  FuelStation({
    required this.id,
    required this.name,
    required this.location,
    required this.contact,
    required this.logo,
    required this.latitude,
    required this.longitude,
    required this.fuelPrices,
  });

  factory FuelStation.fromJson(Map<String, dynamic> json) {
    return FuelStation(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      contact: json['contact'],
      logo: json['logo'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      fuelPrices: Map<String, double>.from(json['fuelPrices']),
    );
  }



  double distanceTo(double lat, double lng) {
    const double earthRadius = 6371; // Earth's radius in km
    double dLat = _toRadians(lat - latitude);
    double dLng = _toRadians(lng - longitude);
    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(latitude)) *
            math.cos(_toRadians(lat)) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * math.pi / 180;
  }


  double getFuelPrice(String fuelType) {
    return fuelPrices[fuelType] ?? 0.0; // Return price for selected fuel type
  }

  String getAddress() {
    // Split location into components and format consistently
    final parts = location.split(',');
    if (parts.length >= 3) {
      // Format as: Street, City, Country
      return '${parts[0].trim()}, ${parts[1].trim()}, ${parts[2].trim()}';
    } else if (parts.length == 2) {
      // Format as: City, Country
      return '${parts[0].trim()}, ${parts[1].trim()}';
    }
    // Return original location if format doesn't match
    return location;
  }


  bool isWithinRadius(double lat, double lng, double radiusKm) {
    return distanceTo(lat, lng) <= radiusKm;
  }

  bool isWithinPriceRange(double minPrice, double maxPrice) {
    return fuelPrices.values.any((price) => price >= minPrice && price <= maxPrice);
  }

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
