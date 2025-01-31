import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart'; // Import the custom bottom navigation bar
import 'report_issue_screen.dart'; // Import the existing report issue screen
import 'favorite_screen.dart'; // Import the existing favorite screen
import 'fuel_map_screen.dart'; // Import the existing fuel map screen
import '../providers/theme_provider.dart'; // Import ThemeProvider

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  int _selectedIndex = 4; // Set the default index for Nearby

  /// Handles navigation based on the tapped index.
  void _onNavigationItemTapped(int index) {
    if (_selectedIndex == index) return; // Avoid unnecessary navigation for the current screen

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/fuel_map'); // Navigate to Fuel Map
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/favorites'); // Navigate to Favorites
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/trends_screen'); // Navigate to Trends
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/my_trip'); // Navigate to My Trips
        break;
      case 4:
        // Stay on Nearby
        break;
      case 5:
        Navigator.pushReplacementNamed(context, '/settings'); // Navigate to Settings
        break;
    }
  }

  String _formatStationName(String name) {
    List<String> words = name.split(' ');
    if (words.length > 4) {
      return "${words.take(4).join(' ')} ....";
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        setState(() {
          _selectedIndex = 0; // Set Home as active
        });
        Navigator.pushReplacementNamed(context, '/fuel_map'); // Navigate to Home
        return false; // Prevent default back behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nearby', style: TextStyle(color: Colors.black)), // Updated to black
          backgroundColor: Provider.of<ThemeProvider>(context).currentTheme.appBarTheme.backgroundColor, // Updated for dark theme
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                _selectedIndex = 0; // Set Home as active
              });
              Navigator.pushReplacementNamed(context, '/fuel_map'); // Navigate to Home
            },
          ),
        ),
        body: SingleChildScrollView(
          // Added scroll functionality
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TotalEnergies Station Information
              _buildStationInfo(
                logoPath: 'assets/images/Total Energies.png',
                stationName: _formatStationName('TotalEnergies Service Station Coropark (Pvt) Ltd'),
                blendPrice: 'Blend E5: 1.34',
                distance: '1.63 km',
              ),
              SizedBox(height: 24),

              // Zuva Grendale Station Information
              _buildStationInfo(
                logoPath: 'assets/images/zuva energy.png', // Assuming the logo path
                stationName: _formatStationName('Zuva Grendale'),
                blendPrice: 'Blend E5: 1.30',
                distance: '2.00 km',
              ),
              SizedBox(height: 24),

              // Energy Park Station Information
              _buildStationInfo(
                logoPath: 'assets/images/energy park.png', // Assuming the logo path
                stationName: _formatStationName('Energy Park'),
                blendPrice: 'Blend E5: 1.25',
                distance: '3.50 km',
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onNavigationItemTapped,
        ),
      ),
    );
  }

  Widget _buildStationInfo(
      {required String logoPath,
      required String stationName,
      required String blendPrice,
      required String distance}) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Provider.of<ThemeProvider>(context).currentTheme.cardColor, // Updated for dark theme
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(logoPath, height: 16), // Logo
              SizedBox(width: 8),
              Text(
                stationName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Updated to black
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                blendPrice,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Updated to black
                ),
              ),
              Row(
                children: [
                  Icon(Icons.location_pin, color: Colors.black), // Updated to black
                  SizedBox(width: 4),
                  Text(distance, style: TextStyle(color: Colors.black)), // Updated to black
                ],
              ),
            ],
          ),
          SizedBox(height: 16),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(Icons.report_problem, 'Report Station', Colors.red, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportIssueScreen()),
                );
              }),
              _buildActionButton(Icons.star, 'Add to Favourite', Colors.blue, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoriteScreen()),
                );
              }),
              _buildActionButton(Icons.directions, 'Take me there', Colors.green, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FuelMapScreen(fuelType: 'Diesel')), // Pass the fuel type
                );
              }),
            ],
          ),
          SizedBox(height: 16),

          // Opening Hours
          Text(
            'OPEN: Closes 11:00 PM',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Updated to black
            ),
          ),
          SizedBox(height: 16),

          // Fuel Prices
          Text('Fuel Prices:', style: TextStyle(fontSize: 18, color: Colors.black)), // Updated to black
          SizedBox(height: 8),
          Text('Diesel: 1.22', style: TextStyle(color: Colors.black)), // Updated to black
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color, VoidCallback onPressed) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            padding: EdgeInsets.all(16),
            child: Icon(icon, color: Colors.white),
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.black)), // Updated to black
      ],
    );
  }
}
