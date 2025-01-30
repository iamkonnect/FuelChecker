class FuelStation {
  final String name;
  final String location;
  final String contact;
  final String logo;
  final Map<String, double> fuelPrices; // Fuel type as key and price as value

  FuelStation({
    required this.name,
    required this.location,
    required this.contact,
    required this.logo,
    required this.fuelPrices,
  });

  double getFuelPrice(String fuelType) {
    return fuelPrices[fuelType] ?? 0.0; // Return price for selected fuel type
  }
}
