import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home, // Home icon
            color: selectedIndex == 0 ? Colors.red : Colors.black,
            size: 24,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.star, // Favorites icon
            color: selectedIndex == 1 ? Colors.red : Colors.black,
            size: 24,
          ),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.grid_view, // Trends icon
            color: selectedIndex == 2 ? Colors.red : Colors.black,
            size: 24,
          ),
          label: 'Trends',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.location_on, // My Trip icon
            color: selectedIndex == 3 ? Colors.red : Colors.black,
            size: 24,
          ),
          label: 'My Trip',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.map, // Nearby icon
            color: selectedIndex == 4 ? Colors.red : Colors.black,
            size: 24,
          ),
          label: 'Nearby',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings, // Settings icon
            color: selectedIndex == 5 ? Colors.red : Colors.black,
            size: 24,
          ),
          label: 'Settings',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.red,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/fuel_map');
            break;
          case 1:
            Navigator.pushNamed(context, '/favorites');
            break;
          case 2:
            Navigator.pushNamed(context, '/trends_screen');
            break;
          case 3:
            Navigator.pushNamed(context, '/my_trip');
            break;
          case 4:
            Navigator.pushNamed(context, '/nearby');
            break;
          case 5:
            Navigator.pushNamed(context, '/settings');
            break;
        }
      },
    );
  }
}
