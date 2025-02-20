import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import 'report_issue_screen.dart';
import 'favorite_screen.dart';
import 'fuel_map_screen.dart';
import '../providers/theme_provider.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  int _selectedIndex = 3;

  void _onNavigationItemTapped(int index) async {
    if (_selectedIndex == index) return;

    try {
      final route = _getRouteForIndex(index);
      if (route != null) {
        await Navigator.pushReplacementNamed(context, route);
        setState(() {
          _selectedIndex = index;
        });
      }
    } catch (e) {
      debugPrint('Navigation error: $e');
    }
  }

  String? _getRouteForIndex(int index) {
    switch (index) {
      case 0: return '/fuel_map';
      case 1: return '/favorites';
      case 2: return '/analytics';
      case 3: return '/nearby';
      case 4: return '/settings';
      default: return null;
    }
  }

  String _formatStationName(String name) {
    List<String> words = name.split(' ');
    if (words.length > 3) {
      return "${words.take(3).join(' ')} ....";
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          setState(() {
            _selectedIndex = 0;
          });
          Navigator.pushReplacementNamed(context, '/fuel_map');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nearby',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color)),
          backgroundColor: Provider.of<ThemeProvider>(context)
              .currentTheme
              .appBarTheme
              .backgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
              Navigator.pushReplacementNamed(context, '/fuel_map');
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStationInfo(
                logoPath: 'assets/images/Total Energies.png',
                stationName: _formatStationName(
                    'TotalEnergies Service Station Coropark (Pvt) Ltd'),
                blendPrice: 'Blend E5: 1.34',
                distance: '1.63 km',
              ),
              const SizedBox(height: 24),
              _buildStationInfo(
                logoPath: 'assets/images/zuva energy.png',
                stationName: _formatStationName('Zuva Grendale'),
                blendPrice: 'Blend E5: 1.30',
                distance: '2.00 km',
              ),
              const SizedBox(height: 24),
              _buildStationInfo(
                logoPath: 'assets/images/energy park.png',
                stationName: _formatStationName('Energy Park'),
                blendPrice: 'Blend E5: 1.25',
                distance: '3.50 km',
              ),
              const SizedBox(height: 24),
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

  Widget _buildStationInfo({
    required String logoPath,
    required String stationName,
    required String blendPrice,
    required String distance,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Provider.of<ThemeProvider>(context)
            .currentTheme
            .cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(logoPath, height: 16),
              const SizedBox(width: 8),
              Text(
                stationName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                blendPrice,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.location_pin,
                      color: Theme.of(context).iconTheme.color),
                  const SizedBox(width: 4),
                  Text(distance,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(
                  Icons.report_problem, 'Report Station', Colors.red, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReportIssueScreen()),
                );
              }),
              _buildActionButton(Icons.star, 'Add to Favourite', Colors.blue,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoriteScreen()),
                );
              }),
              _buildActionButton(
                  Icons.directions, 'Take me there', Colors.green, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FuelMapScreen(
                          fuelType: 'Diesel')),
                );
              }),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'OPEN: Closes 11:00 PM',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 16),
          Text('Fuel Prices:',
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyLarge?.color)),
          const SizedBox(height: 8),
          Text('Diesel: 1.22',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color)),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, Color color, VoidCallback onPressed) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            padding: const EdgeInsets.all(16),
            child: Icon(icon, color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color)),
      ],
    );
  }
}
