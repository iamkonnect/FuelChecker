import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: Image.asset('./assets/arrow-left.png'),
            onPressed: () {},
          ),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSettingsTile('Filter Fuel Brands', trailing: Text('All Brands')),
            _buildSettingsTile('About'),
            _buildSettingsTile('Notifications'),
            _buildSettingsTile('Help'),
            _buildSettingsTile('Feedback'),
            _buildSettingsTile('Report an Issue'),
            _buildSettingsTile('Share App'),
            _buildSettingsTile('Analytics'),
            _buildSettingsTile('Deactivate Account'),
            _buildSettingsTile('Log Out'),
            SizedBox(height: 20),
            Column(
              children: [
                Image.asset('./assets/logo-full-color-150-x-1.png', height: 100),
                SizedBox(height: 10),
                Text(
                  'Fuel Check v1.0',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(String text, {Widget? trailing}) {
    return Column(
      children: [
        ListTile(
          title: Text(
            text,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          trailing: trailing ?? SizedBox(),
        ),
        Divider(thickness: 1.0),
      ],
    );
  }
}
