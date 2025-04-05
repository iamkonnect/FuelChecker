import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/favorites_service.dart';
import '../models/fuel_gas_station.dart';
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

    setState(() => _selectedIndex = index);

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
      case 3:
        Navigator.pushReplacementNamed(context, '/nearby');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  String _shortenName(String name) {
    final words = name.split(' ');
    return words.length > 4 ? '${words.take(4).join(' ')}...' : name;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/fuel_map');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Stations'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/fuel_map'),
          ),
        ),
        body: Consumer<FavoritesService>(
          builder: (context, favoritesService, child) {
            final favorites = favoritesService.favorites;

            if (favorites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border,
                        size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 20),
                    Text('No Favorite Stations',
                        style:
                            TextStyle(fontSize: 18, color: Colors.grey[600])),
                    const SizedBox(height: 10),
                    Text('Tap the heart icon on gas stations\nto add them here',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[500])),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final station = favorites[index];

                return Material(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).cardColor,
                  elevation: 2,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      // Add navigation to station details if needed
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Station Logo
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(station.logoAsset),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Station Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _shortenName(station.name),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        station.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: station.isFavorite
                                            ? Colors.redAccent
                                            : Colors.grey,
                                      ),
                                      onPressed: () => favoritesService
                                          .toggleFavorite(station),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(station.town,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    )),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    _buildPriceChip(
                                        'Blend', station.blendPrice),
                                    const SizedBox(width: 8),
                                    _buildPriceChip(
                                        'Diesel', station.dieselPrice),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        size: 16, color: Colors.grey[600]),
                                    const SizedBox(width: 4),
                                    Text(
                                        'Open Now', // Add real opening hours logic
                                        style: TextStyle(
                                          color: Colors.green[700],
                                          fontSize: 14,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildPriceChip(String fuelType, double price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: '$fuelType: ',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                )),
            TextSpan(
                text: '\$${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                )),
          ],
        ),
      ),
    );
  }
}
