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
    );
  }
}
