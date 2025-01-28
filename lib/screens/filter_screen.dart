import 'package:flutter/material.dart';
import '../widgets/fuel_calculator.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
      ),
      body: const FuelCalculator(),
    );
  }
}
