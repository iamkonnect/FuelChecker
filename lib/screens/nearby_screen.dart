import 'package:flutter/material.dart';

class FuelStation {
  final String name;
  final String distance;
  final double blendESPrice;
  final double dieselPrice;

  FuelStation({
    required this.name,
    required this.distance,
    required this.blendESPrice,
    required this.dieselPrice,
  });
}

class FuelCheckerApp extends StatefulWidget {
  const FuelCheckerApp({Key? key}) : super(key: key);

  @override
  _FuelCheckerAppState createState() => _FuelCheckerAppState();
}

class _FuelCheckerAppState extends State<FuelCheckerApp> {
  final List<FuelStation> fuelStations = [
    FuelStation(
      name: 'Puma Petroleum',
      distance: '3 km away',
      blendESPrice: 1.39,
      dieselPrice: 1.59,
    ),
    FuelStation(
      name: 'Puma Petroleum',
      distance: '3 km away',
      blendESPrice: 1.36,
      dieselPrice: 1.50,
    ),
    FuelStation(
      name: 'Puma Petroleum',
      distance: '3 km away',
      blendESPrice: 1.27,
      dieselPrice: 1.40,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Nearby'),
      ),
      body: ListView.builder(
        itemCount: fuelStations.length,
        itemBuilder: (context, index) {
          final fuelStation = fuelStations[index];
          return Card(
            child: ListTile(
              leading: Image.asset('assets/puma_logo.png'),
              title: Text(fuelStation.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fuelStation.distance),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Blend ES: \$${fuelStation.blendESPrice.toStringAsFixed(2)}'),
                      const SizedBox(width: 16),
                      Text('Diesel: \$${fuelStation.dieselPrice.toStringAsFixed(2)}'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
