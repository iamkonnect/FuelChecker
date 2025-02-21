class GasStation {
  final String id;
  final String name;
  final String town;
  final double latitude;
  final double longitude;
  final double petrolPrice;
  final double dieselPrice;
  final String logoAsset;

  GasStation({
    required this.id,
    required this.name,
    required this.town,
    required this.latitude,
    required this.longitude,
    required this.petrolPrice,
    required this.dieselPrice,
    required this.logoAsset,
  });

  factory GasStation.fromMap(String id, Map<String, dynamic> data) {
    return GasStation(
      id: id,
      name: data['name'],
      town: data['town'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      petrolPrice: data['petrolPrice'],
      dieselPrice: data['dieselPrice'],
      logoAsset: data['logoAsset'],
    );
  }
}
