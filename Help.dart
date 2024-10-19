/* Help.dart */
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HelpScreen(),
    );
  }
}

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Help',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 35,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('./assets/arrow-left.png'),
          onPressed: () {
            _navigateToLocationScreen(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                _requestCheapestFuelInfo();
              },
              child: _buildSectionTitle('Find the cheapest fuel on my route'),
            ),
            _buildSectionContent('1. Fuel Check gives you...'),
            SizedBox(height: 42),
            GestureDetector(
              onTap: () {
                _setFavouriteStation();
              },
              child: _buildSectionTitle('Set a favourite station'),
            ),
            _buildSectionContent('1. Fuel Check gives you...'),
            SizedBox(height: 42),
            GestureDetector(
              onTap: () {
                _enableNotifications();
              },
              child: _buildSectionTitle('Notification'),
            ),
            _buildSectionContent('1. Fuel Check gives you...'),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 10,
        child: Image.asset('./assets/rectangle-9.png'),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        content,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  void _navigateToLocationScreen(BuildContext context) {
    // Simulate navigation back to the location screen
    Navigator.of(context).pop();
    // Or push to location screen if it’s a separate screen
    // Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen()));
  }

  void _requestCheapestFuelInfo() {
    // Simulate request to the backend to find the cheapest fuel
    print('Requesting the cheapest fuel info...');
    // Display notification about the results (or mock data)
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Notification'),
        content: Text('Cheapest fuel info received! Check your app updates for details.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _setFavouriteStation() {
    // Simulate setting the favourite fuel station
    print('Setting Puma Petroleum as your favourite fuel station...');
    // Display confirmation
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Favourite Station'),
        content: Text('Puma Petroleum has been set as your favourite station.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _enableNotifications() {
    // Simulate enabling notifications for updates
    print('Enabling notifications...');
    // Notify the user
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Notification'),
        content: Text('Notifications have been enabled for updates.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

