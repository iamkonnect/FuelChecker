import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importing the LoginScreen
import '../widgets/custom_bottom_navigation_bar.dart'; // Import the custom bottom navigation bar

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _brightness = 0.5; // Default brightness value
  bool _notificationsEnabled = true; // Default notification toggle state
  String _selectedTheme = 'light'; // Default theme selection
  int _selectedIndex = 4; // Index for Settings

  /// Handles navigation based on the tapped index.
  void _onNavigationItemTapped(int index) {
    if (_selectedIndex == index) {
      return; // Avoid unnecessary rebuilds for the current screen
    }

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

  /// Ensures proper navigation and updates `_selectedIndex` on back press.
  Future<bool> _onWillPop() async {
    setState(() {
      _selectedIndex = 0; // Update index to Home
    });
    Navigator.pushReplacementNamed(context, '/fuel_map'); // Navigate to Home
    return false; // Prevents default back button behavior
  }

  /// Builds a custom setting card.
  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.red.shade700),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 28),
            ],
          ),
        ),
      ),
    );
  }

  void _showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Theme',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('Light Theme'),
                leading: Radio<String>(
                  value: 'light',
                  groupValue: _selectedTheme,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedTheme = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: const Text('Dark Theme'),
                leading: Radio<String>(
                  value: 'dark',
                  groupValue: _selectedTheme,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedTheme = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Adjust Brightness',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.red,
                  inactiveTrackColor: Colors.red.withAlpha(75),
                  thumbColor: Colors.red,
                  overlayColor: Colors.red.withAlpha(50),
                  trackHeight: 4.0,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 20.0),
                ),
                child: Slider(
                  value: _brightness,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  label: '${(_brightness * 100).toStringAsFixed(0)}%',
                  onChanged: (double value) {
                    setState(() {
                      _brightness = value;
                    });
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Brightness: ${(_brightness * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Handle back button behavior
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SwitchListTile(
                    title: const Text('Notifications'),
                    value: _notificationsEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                    activeColor: Colors.red,
                    activeTrackColor: Colors.red.shade200,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingCard(
                  icon: Icons.person,
                  title: 'Profile Details',
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                const SizedBox(height: 16),
                _buildSettingCard(
                  icon: Icons.language,
                  title: 'Language Settings',
                  onTap: () {
                    Navigator.pushNamed(context, '/language');
                  },
                ),
                const SizedBox(height: 16),
                _buildSettingCard(
                  icon: Icons.brightness_6,
                  title: 'Theme & Display',
                  onTap: () => _showThemeBottomSheet(context),
                ),
                const SizedBox(height: 16),
                // _buildSettingCard(
                //   icon: Icons.analytics,
                //   title: 'Analytics',
                //   onTap: () {
                //     Navigator.pushNamed(context, '/analytics');
                //   },
                // ),
                const SizedBox(height: 16),
                _buildSettingCard(
                  icon: Icons.info,
                  title: 'About',
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                const SizedBox(height: 16),
                _buildSettingCard(
                  icon: Icons.help,
                  title: 'Help',
                  onTap: () {
                    Navigator.pushNamed(context, '/help');
                  },
                ),
                const SizedBox(height: 16),
                _buildSettingCard(
                  icon: Icons.feedback,
                  title: 'Feedback',
                  onTap: () {
                    Navigator.pushNamed(context, '/feedback');
                  },
                ),
                const SizedBox(height: 16),
                _buildSettingCard(
                  icon: Icons.report,
                  title: 'Report an Issue',
                  onTap: () {
                    Navigator.pushNamed(context, '/report');
                  },
                ),
                const SizedBox(height: 16),
                _buildSettingCard(
                  icon: Icons.remove_circle,
                  title: 'Deactivate Account',
                  onTap: () {
                    Navigator.pushNamed(context, '/deactivate');
                  },
                ),
                const SizedBox(height: 16),
                _buildSettingCard(
                  icon: Icons.logout,
                  title: 'Log Out',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onNavigationItemTapped,
        ),
      ),
    );
  }
}
