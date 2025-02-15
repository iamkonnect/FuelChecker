import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
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

  // Helper method to shorten the station name
  String _shortenStationName(String stationName) {
    final words = stationName.split(' ');
    if (words.length > 4) {
      return words.take(4).join(' ') + '...';
    }
    return stationName;
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
          title: const Text('Favorites'),
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
                child: Text('No favorite fuel stations added.',
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              );
            }
            return ListView.builder(
              itemCount: favoriteProvider.favorites.length,
              itemBuilder: (context, index) {
                final station = favoriteProvider.favorites[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(station.logo),
                    ),
                    title: Text(
                      _shortenStationName(station.name),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(station.location,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(
                          '\$${station.getFuelPrice('diesel')} per gallon',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Fuel Type: Diesel',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Contact: ${station.contact}',
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
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
