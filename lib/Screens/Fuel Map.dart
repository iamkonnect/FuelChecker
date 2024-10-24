import 'package:flutter/material.dart';

void main() {
  runApp(FuelStationsApp());
}

class FuelStationsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Stations',
      home: FuelMapPage(),
    );
  }
}

class FuelMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
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
          Positioned(
            top: 84,
            left: 329,
            child: FuelStationPrice(
              imagePath: './assets/icon_station.png',
              price: 'Diesel\n\$1.56',
            ),
          ),
          Positioned(
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
            child: FuelTypeBox(),
          ),

          // Bottom Navigation Bar
          Positioned(
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

  FuelStationPrice({required this.imagePath, required this.price});

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
          padding: EdgeInsets.all(4),
          child: Text(
            price,
            style: TextStyle(fontSize: 8, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class FuelTypeBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305,
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFF3F4F6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Choose Station',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0x801E232E),
            ),
          ),
          Icon(Icons.search),
        ],
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 108,
        decoration: BoxDecoration(
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
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
