import 'package:flutter/material.dart';
import 'feedback_screen.dart'; // Import the FeedbackScreen

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

class NearbyScreen extends StatelessWidget {
  const NearbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FuelStation> fuelStations = [
      FuelStation(
        name: 'Puma Petroleum',
        distance: '3 km away',
        blendESPrice: 1.39,
        dieselPrice: 1.59,
      ),
      FuelStation(
        name: 'Shell',
        distance: '5 km away',
        blendESPrice: 1.36,
        dieselPrice: 1.50,
      ),
      FuelStation(
        name: 'Totalenergies',
        distance: '7 km away',
        blendESPrice: 1.27,
        dieselPrice: 1.40,
      ),
    ];

    // Show feedback prompt after displaying fuel stations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (fuelStations.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Feedback'),
              content: const Text('Would you like to provide feedback on the fuel stations displayed?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedbackScreen()), // Navigate to FeedbackScreen
                    );
                  },
                ),
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Nearby'),
      ),
      body: fuelStations.isEmpty
          ? const Center(child: Text('No fuel stations available.'))
          : ListView.builder(
              itemCount: fuelStations.length,
              itemBuilder: (context, index) {
                final fuelStation = fuelStations[index];
                return Card(
                  child: ListTile(
                    leading: Image.asset('lib/assets/images/logo-full-color-150-x-1.png'),
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
