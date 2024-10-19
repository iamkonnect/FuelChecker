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
            _buildSettingsTile(context, 'Filter Fuel Brands', trailing: Text('All Brands')),
            _buildSettingsTile(context, 'About', routeName: '/about'),
            _buildSettingsTile(context, 'Notifications', routeName: '/notifications'),
            _buildSettingsTile(context, 'Help', routeName: '/help'),
            _buildSettingsTile(context, 'Feedback', routeName: '/feedback'),
            _buildSettingsTile(context, 'Report an Issue'),
            _buildSettingsTile(context, 'Share App', routeName: '/share_app'),
            _buildSettingsTile(context, 'Analytics', routeName: '/analytics'),
            _buildSettingsTile(context, 'Deactivate Account', routeName: '/deactivate_account'),
            _buildSettingsTile(context, 'Log Out', routeName: '/logout'),
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

  Widget _buildSettingsTile(BuildContext context, String text, {Widget? trailing, String? routeName}) {
    return Column(
      children: [
        ListTile(
          title: Text(
            text,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          trailing: trailing ?? SizedBox(),
          onTap: routeName != null
            ? () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _getPage(routeName)),
              )
            : null,
        ),
        Divider(thickness: 1.0),
      ],
    );
  }

  Widget _getPage(String routeName) {
    switch (routeName) {
      case '/about':
        return AboutPage();
      case '/notifications':
        return NotificationsPage();
      case '/help':
        return HelpPage();
      case '/feedback':
        return FeedbackPage();
      case '/share_app':
        return ShareAppPage();
      case '/analytics':
        return AnalyticsPage();
      case '/deactivate_account':
        return DeactivateAccountPage();
      case '/logout':
        return LogoutPage();
      default:
        return SettingsPage();
    }
  }
}

// Placeholder pages
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('About')), body: Center(child: Text('About the application...')));
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Notifications')), body: Center(child: Text('Manage notifications.')));
  }
}

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Help')), body: Center(child: Text('Help and support.')));
  }
}

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Feedback')), body: Center(child: Text('Provide feedback here.')));
  }
}

class ShareAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Share App')), body: Center(child: Text('Share the app with friends!')));
  }
}

class AnalyticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Analytics')), body: Center(child: Text('View app analytics here.')));
  }
}

class DeactivateAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Deactivate Account')), body: Center(child: Text('Deactivate your account here.')));
  }
}

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Log Out')), body: Center(child: Text('Log out from the app.')));
  }
}
