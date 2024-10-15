import 'package:flutter/material.dart';

void main() {
  runApp(FuelStationsApp());
}

class FuelStationsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FuelStationsScreen(),
    );
  }
}

class FuelStationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: Stack(
        children: [
          // Status Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset('./assets/i-os-status-bar-black.svg'),
          ),
          // Main map and stations
          Positioned.fill(
            top: 44,
            bottom: 100,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        // Map background
                        Positioned.fill(
                          child: Image.asset(
                            './assets/rectangle-776.svg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Station widgets
                        Positioned(
                          top: 77,
                          left: 65,
                          child: StationWidget(
                            imageAsset: './assets/iconly-light-location-5.svg',
                            label: "Blend E5\n\$1.40",
                          ),
                        ),
                        Positioned(
                          top: 201,
                          left: 168,
                          child: StationWidget(
                            imageAsset: './assets/iconly-light-location-4.svg',
                            label: "Blend E5\n\$1.50",
                          ),
                        ),
                        // Add more stations similar to above...
                      ],
                    ),
                  ),
                  // Search box
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 11.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFFF3F4F6)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Choose Station",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0x1E232E80),
                              ),
                            ),
                          ),
                          Image.asset(
                            './assets/iconly-light-search.svg',
                            width: 25.17,
                            height: 20.43,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBottomNavItem('./assets/image-2.svg', "Trends"),
                  _buildBottomNavItem('./assets/image-10.svg', "My Trip"),
                  _buildBottomNavItem('./assets/image-6.svg', "Nearby"),
                  _buildBottomNavItem('./assets/image-8.svg', "Favourite"),
                  _buildBottomNavItem('./assets/image-4.svg', "Settings"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(String icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(icon, width: 25, height: 25),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class StationWidget extends StatelessWidget {
  final String imageAsset;
  final String label;

  StationWidget({required this.imageAsset, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageAsset, width: 39, height: 43),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
