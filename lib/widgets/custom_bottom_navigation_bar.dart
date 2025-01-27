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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home), // Home icon
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star), // Favorites icon
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view), // Trends icon
          label: 'Trends',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on), // My Trip icon
          label: 'My Trip',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map), // Nearby icon
          label: 'Nearby',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings), // Settings icon
          label: 'Settings',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.red, // Active state color
      unselectedItemColor: Colors.black, // Inactive state color
      onTap: onItemTapped, // Passes the tapped index to the parent
    );
  }
}
