class FuelPrice {
  final double pricePerLiter;
  final double liters;

  FuelPrice({required this.pricePerLiter, required this.liters});

  double calculateTotal() {
    return pricePerLiter * liters;
  }
}
