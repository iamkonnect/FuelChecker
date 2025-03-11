import 'package:cloud_firestore/cloud_firestore.dart';

class GasStation {
  final String id;
  final String name;
  final String town;
  final double latitude;
  final double longitude;
  final double blendPrice;
  final double dieselPrice;
  final String logoAsset;
  final String stationIcon;
  final bool isOpen;

  GasStation({
    required this.id,
    required this.name,
    required this.town,
    required this.latitude,
    required this.longitude,
    required this.blendPrice,
    required this.dieselPrice,
    required this.logoAsset,
    required this.stationIcon,
    required this.isOpen,
  });

  // For Firestore documents
  factory GasStation.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GasStation(
      id: doc.id,
      name: data['name'] ?? 'Unknown Station',
      town: data['town'] ?? '',
      latitude: (data['latitude'] as num).toDouble(),
      longitude: (data['longitude'] as num).toDouble(),
      blendPrice: (data['blendPrice'] as num).toDouble(),
      dieselPrice: (data['dieselPrice'] as num).toDouble(),
      logoAsset: data['logoAsset'] ?? 'assets/Logo/default.png',
      stationIcon: data['stationIcon'] ?? '',
      isOpen: data['isOpen'] ?? false,
    );
  }

  // For local data migration
  factory GasStation.fromMap(String id, Map<String, dynamic> data) {
    return GasStation(
      id: id,
      name: data['name'] ?? 'Unknown Station',
      town: data['town'] ?? '',
      latitude: (data['latitude'] as num).toDouble(),
      longitude: (data['longitude'] as num).toDouble(),
      blendPrice: (data['blendPrice'] as num).toDouble(),
      dieselPrice: (data['dieselPrice'] as num).toDouble(),
      logoAsset: data['logoAsset'] ?? 'assets/Logo/default.png',
      stationIcon: data['stationIcon'] ?? '',
      isOpen: data['isOpen'] ?? true,
    );
  }
}
