import 'package:flutter/material.dart';

void main() {
  runApp(const FuelStationsApp());
}

class FuelStationsApp extends StatelessWidget {
  const FuelStationsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fuel Stations',
      home: FuelMapPage(),
    );
  }
}

class FuelMapPage extends StatelessWidget {
  const FuelMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Stack(
        children: [
          // Google Map Placeholder
          Positioned.fill(
            child: Image.asset(
              './assets/map_placeholder.jpg', // Replace with actual map image or map widget
              fit: BoxFit.cover,
            ),
          ),
          // Fuel Station Icons with Prices
          const Positioned(
            top: 84,
            left: 329,
            child: FuelStationPrice(
              imagePath: './assets/icon_station.png',
              price: 'Diesel\n\$1.56',
            ),
          ),
          const Positioned(
            top: 348,
            left: 303,
            child: FuelStationPrice(
              imagePath: './assets/icon_station.png',
              price: 'Blend E5\n\$1.27',
            ),
          ),
          // More station markers go here...

          // Search Bar
          Positioned(
            top: MediaQuery.of(context).size.height - 182,
            left: MediaQuery.of(context).size.width / 2 - 152.5,
            child: const FuelTypeBox(),
          ),

          // Bottom Navigation Bar
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigation(),
          ),
        ],
      ),
    );
  }
}

class FuelStationPrice extends StatelessWidget {
  final String imagePath;
  final String price;

  const FuelStationPrice({super.key, required this.imagePath, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          width: 44,
          height: 44,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(4),
          child: Text(
            price,
            style: const TextStyle(fontSize: 8, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class FuelTypeBox extends StatelessWidget {
  const FuelTypeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305,
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image.asset('assets/images/diesel_logo.png', width: 40), // Example logo
              const Text('Diesel'),
            ],
          ),
          Column(
            children: [
              Image.asset('assets/images/petrol_logo.png', width: 40), // Example logo
              const Text('Petrol'),
            ],
          ),
          const Icon(Icons.search),
        ],
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 108,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('./assets/icon_trends.png', 'Trends'),
            _buildNavItem('./assets/icon_my_trip.png', 'My Trip'),
            _buildNavItem('./assets/icon_nearby.png', 'Nearby'),
            _buildNavItem('./assets/icon_favourite.png', 'Favourite'),
            _buildNavItem('./assets/icon_settings.png', 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String imagePath, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath,
          width: 25,
          height: 25,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
