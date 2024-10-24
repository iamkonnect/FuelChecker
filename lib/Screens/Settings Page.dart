import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings UI',
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  void _navigateTo(BuildContext context, String pageName) {
    print('Navigating to $pageName');
    // Add navigation logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('./assets/arrow-left.svg'),
          onPressed: () {
            // Go back logic
          },
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text("Filter Fuel Brands"),
              trailing: Text("All Brands", style: TextStyle(color: Colors.black.withOpacity(0.5))),
              onTap: () => _navigateTo(context, 'Fuel Brand Page'),
            ),
            Divider(),
            _buildListTile(context, 'About', 'About Page'),
            _buildListTile(context, 'Notifications', 'Notification Page'),
            _buildListTile(context, 'Help', 'Help Page'),
            _buildListTile(context, 'Feedback', 'Feedback Page'),
            _buildListTile(context, 'Report an Issue', 'Report Page'),
            _buildListTile(context, 'Share App', 'Share App Page'),
            _buildListTile(context, 'Analytics', 'Analytic Page'),
            _buildListTile(context, 'Deactivate Account', 'Deactivate Account Page'),
            _buildListTile(context, 'Log Out', 'Logout Page'),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('./assets/logo-full-color-150-x-1.svg', width: 100),
                SizedBox(height: 10),
                Text("Fuel Check v1.0", style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, String pageName) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          onTap: () => _navigateTo(context, pageName),
        ),
        Divider(),
      ],
    );
  }
}
