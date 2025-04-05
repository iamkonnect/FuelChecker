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
  bool isFavorite;

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
    this.isFavorite = false, // Optional with default value
  });

  factory GasStation.fromMap(String id, Map<String, dynamic> data) {
    return GasStation(
      id: id,
      name: data['name'],
      town: data['town'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      blendPrice: data['blendPrice'],
      dieselPrice: data['dieselPrice'],
      logoAsset: data['logoAsset'],
      stationIcon: data['stationIcon'],
      // isFavorite will default to false if not specified
    );
  }

  // Optional: Add method to toggle favorite status
  GasStation copyWith({bool? isFavorite}) {
    return GasStation(
      id: id,
      name: name,
      town: town,
      latitude: latitude,
      longitude: longitude,
      blendPrice: blendPrice,
      dieselPrice: dieselPrice,
      logoAsset: logoAsset,
      stationIcon: stationIcon,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GasStation && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
