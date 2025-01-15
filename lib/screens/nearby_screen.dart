import 'package:flutter/material.dart';

class NearbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby'),
      ),
      body: Center(
        child: Text('Nearby Screen Content'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('lib/assets/images/Favourites.png'), color: Colors.black), label: 'Favorites'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('lib/assets/images/Trends.png'), color: Colors.black), label: 'Trends'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('lib/assets/images/my trips.png'), color: Colors.black), label: 'My Trips'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('lib/assets/images/nearby.png'), color: Colors.black), label: 'Nearby'),
          BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.black), label: 'Settings'),
        ],
      ),
    );
  }
}
