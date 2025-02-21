class GasStation {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final double petrolPrice;
  final double dieselPrice;
  final String logoUrl;

  GasStation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.petrolPrice,
    required this.dieselPrice,
    required this.logoUrl,
  });

  factory GasStation.fromMap(String id, Map<String, dynamic> data) {
    return GasStation(
      id: id,
      name: data['name'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      petrolPrice: data['petrolPrice'],
      dieselPrice: data['dieselPrice'],
      logoUrl: data['logoUrl'],
    );
  }
}
