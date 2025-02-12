import 'package:flutter/material.dart';

/// Custom widget for BottomNavigationBar with active and inactive states.
class CustomBottomNavigationBar extends StatelessWidget {
  /// The currently selected index of the navigation bar.
  final int selectedIndex;

  /// Callback function to handle item tap events.
  final Function(int) onItemTapped;

  /// Constructor to initialize the required parameters.
  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        _buildNavigationBarItem(
          icon: Icons.home,
          label: 'Home',
        ),
        _buildNavigationBarItem(
          icon: Icons.star,
          label: 'Favorites',
        ),
        _buildNavigationBarItem(
          icon: Icons.grid_view,
          label: 'Trends',
        ),
        // _buildNavigationBarItem(
        //   icon: Icons.map,
        //   label: 'My Trip',
        // ),
        _buildNavigationBarItem(
          icon: Icons.location_on,
          label: 'Nearby',
        ),
        _buildNavigationBarItem(
          icon: Icons.settings,
          label: 'Settings',
        ),
      ],
      currentIndex: selectedIndex, // Indicates the currently active tab.
      selectedItemColor: Colors.red, // Active state color for icon and label.
      unselectedItemColor:
          Colors.black, // Inactive state color for icon and label.
      showUnselectedLabels: true, // Ensures labels are visible for all items.
      type: BottomNavigationBarType.fixed, // Ensures all items are visible.
      onTap: onItemTapped, // Handles item tap events.
    );
  }

  /// Helper method to build a BottomNavigationBarItem.
  BottomNavigationBarItem _buildNavigationBarItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
