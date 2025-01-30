import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedIndex = 1;

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
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/trends_screen');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/my_trip');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/nearby');
        break;
      case 5:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _selectedIndex = 0;
        });
        Navigator.pushReplacementNamed(context, '/fuel_map');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)), // Updated for dark theme
          backgroundColor: Provider.of<ThemeProvider>(context).currentTheme.appBarTheme.backgroundColor, // Updated for dark theme
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
        body: Consumer<FavoriteProvider>(
          builder: (context, favoriteProvider, child) {
            if (favoriteProvider.favorites.isEmpty) {
              return const Center(
                child: Text('No favorite fuel stations added.', style: TextStyle(fontSize: 18, color: Colors.grey)),
              );
            }
            return ListView.builder(
              itemCount: favoriteProvider.favorites.length,
              itemBuilder: (context, index) {
                final station = favoriteProvider.favorites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Provider.of<ThemeProvider>(context).currentTheme.cardColor, // Updated for dark theme
                  child: ListTile(
                    leading: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(station.logo),
                    ),
                    title: Text(station.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)), // Updated for dark theme
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(station.location, style: TextStyle(fontSize: 16, color: Colors.white)), // Updated for dark theme
                        const SizedBox(height: 4),
                        Text(
                          '\$${station.getFuelPrice('diesel')} per litre',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white), // Updated for dark theme
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Fuel Type: Diesel',
                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white), // Updated for dark theme
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Contact: ${station.contact}',
                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white), // Updated for dark theme
                        ),
                      ],
                    ),
                  ),
                );
              },
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
