import 'package:flutter/material.dart';
import 'fuel_map_screen.dart'; // Add this import statement

class FuelTypeSelectionScreen extends StatefulWidget {
  const FuelTypeSelectionScreen({super.key});

  @override
  State<FuelTypeSelectionScreen> createState() => _FuelTypeSelectionScreenState();
}

class _FuelTypeSelectionScreenState extends State<FuelTypeSelectionScreen> {
  String? _selectedFuelType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Updated to use Google Icons equivalent
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Fuelcheck logo 150by1.png', height: 300), // Updated path

            const SizedBox(height: 32.0),
            const Text(
              'Please select your Fuel Type',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedFuelType,
              hint: const Text('Choose your fuel type'),
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem(value: 'Blend E5', child: Text('Blend E5')),
                DropdownMenuItem(value: 'Diesel', child: Text('Diesel')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedFuelType = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Your preferred fuel type will be used to send notifications. You can configure and make adjustments on your fuel types and brand filtering at anytime in these settings.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                if (_selectedFuelType != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FuelMapScreen(fuelType: _selectedFuelType!),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16.0),
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
