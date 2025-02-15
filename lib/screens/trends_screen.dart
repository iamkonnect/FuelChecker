import 'package:flutter/material.dart';
import '../models/trend.dart'; // Import the Trend model
import '../widgets/custom_bottom_navigation_bar.dart'; // Import the custom bottom navigation bar

class TrendsScreen extends StatefulWidget {
  const TrendsScreen({Key? key}) : super(key: key);

  @override
  State<TrendsScreen> createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen> {
  int _selectedIndex = 2; // Set the default index for Trends

  /// Handles navigation based on the tapped index.
  void _onNavigationItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/fuel_map');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/favorites');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/analytics');
        break;
      case 3: // Nearby (previously My Trip)
        Navigator.pushReplacementNamed(context, '/nearby');
        break;
      case 4: // Settings (previously Nearby)
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  final List<Trend> trends = [
    Trend(
      title: 'Petrol Price Trends',
      description: 'Current trends in petrol prices over the last month.',
      cheapestFillDay: 'Monday',
      priceRange: '\$1.20 - \$1.50',
    ),
    Trend(
      title: 'Best Days to Fill',
      description: 'The cheapest days to fill your tank this week.',
      cheapestFillDay: 'Wednesday',
      priceRange: '\$1.15 - \$1.45',
    ),
    Trend(
      title: 'Local Price Comparison',
      description: 'Compare petrol prices in your local area.',
      cheapestFillDay: 'Friday',
      priceRange: '\$1.10 - \$1.40',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        setState(() {
          _selectedIndex = 0; // Set Home as active
        });
        Navigator.pushReplacementNamed(
            context, '/fuel_map'); // Navigate to Home
        return false; // Prevent default back behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trends'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                _selectedIndex = 0; // Set Home as active
              });
              Navigator.pushReplacementNamed(
                  context, '/fuel_map'); // Navigate to Home
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.near_me),
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, '/nearby'); // Navigate to Nearby
              },
              tooltip: 'Nearby',
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: trends.length,
          itemBuilder: (context, index) {
            final trend = trends[index];
            return Card(
              child: ListTile(
                title: Text(trend.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trend.description),
                    Text('Cheapest Fill Day: ${trend.cheapestFillDay}'),
                    Text('Price Range: ${trend.priceRange}'),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onNavigationItemTapped,
        ),
      ),
    );
  }
}
