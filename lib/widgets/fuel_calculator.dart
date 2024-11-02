import 'package:flutter/material.dart';
import '../models/fuel_price.dart';

class FuelCalculator extends StatefulWidget {
  const FuelCalculator({super.key});

  @override
  State<FuelCalculator> createState() => _FuelCalculatorState();
}

class _FuelCalculatorState extends State<FuelCalculator> {
  final _priceController = TextEditingController();
  final _litersController = TextEditingController();
  double _total = 0.0;

  void _calculateTotal() {
    final price = double.tryParse(_priceController.text) ?? 0;
    final liters = double.tryParse(_litersController.text) ?? 0;
    
    final calculator = FuelPrice(pricePerLiter: price, liters: liters);
    setState(() {
      _total = calculator.calculateTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price per liter'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _litersController,
              decoration: const InputDecoration(labelText: 'Liters'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _calculateTotal,
              child: const Text('Calculate'),
            ),
            Text('Total: \$${_total.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _priceController.dispose();
    _litersController.dispose();
    super.dispose();
  }
}