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
    this.isFavorite = false,
  });

  factory GasStation.fromMap(String id, Map<String, dynamic> data) {
    return GasStation(
      id: id,
      name: data['name'] ?? 'Unknown Station',
      town: data['town'] ?? data['vicinity'] ?? 'Unknown Area',
      latitude:
          (data['latitude'] ?? data['geometry']['location']['lat'])?.toDouble(),
      longitude: (data['longitude'] ?? data['geometry']['location']['lng'])
          ?.toDouble(),
      blendPrice: (data['blendPrice'] ?? 0.0).toDouble(),
      dieselPrice: (data['dieselPrice'] ?? 0.0).toDouble(),
      logoAsset: data['logoAsset'] ?? _getDefaultLogo(data['name']),
      stationIcon: data['stationIcon'] ??
          data['icon'] ??
          'https://fonts.gstatic.com/s/i/materialicons/local_gas_station/v12/24px.svg',
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  static String _getDefaultLogo(String? name) {
    final cleanedName = name?.toLowerCase() ?? '';
    if (cleanedName.contains('shell')) return 'assets/logos/shell.png';
    if (cleanedName.contains('bp')) return 'assets/logos/bp.png';
    return 'assets/logos/default_station.png';
  }

  GasStation copyWith({
    double? blendPrice,
    double? dieselPrice,
    String? logoAsset,
    String? stationIcon,
    bool? isFavorite,
  }) {
    return GasStation(
      id: id,
      name: name,
      town: town,
      latitude: latitude,
      longitude: longitude,
      blendPrice: blendPrice ?? this.blendPrice,
      dieselPrice: dieselPrice ?? this.dieselPrice,
      logoAsset: logoAsset ?? this.logoAsset,
      stationIcon: stationIcon ?? this.stationIcon,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GasStation && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'GasStation($id, $name, $blendPrice/$dieselPrice)';
  }
}
