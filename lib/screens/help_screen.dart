import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
        elevation: 5,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          indicatorWeight: 4,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Apple Devices'),
            Tab(text: 'Android Devices'),
            Tab(text: 'Desktop'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewSection(),
          _buildAppleSection(),
          _buildAndroidSection(),
          _buildDesktopSection(),
        ],
      ),
    );
  }

  Widget _buildOverviewSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('Older Devices'),
          _buildText(
              'If you are using an older mobile device such as iPhone 4, some functionality of Fuel Check may not be supported.'),
          const SizedBox(height: 20.0),
          _buildTitle('Location Services'),
          _buildText(
            'Location Services allow Fuel Check to use information from cellular, Wi-Fi, and GPS networks to determine your approximate location. '
            'To use features like finding your nearest service station, enable Location Services on your device and browser.',
          ),
          const SizedBox(height: 20.0),
          const Text(
            'General Instructions:',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(height: 10.0),
          _buildList([
            'Open your browser app.',
            'Go to fuelcheck.co.zw.',
            'Touch Allow on the message that shows up.',
          ]),
        ],
      ),
    );
  }

  Widget _buildAppleSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('Apple Mobile Devices (iOS 8)'),
          _buildList([
            'Tap the Settings application.',
            'Tap Privacy.',
            'Tap Location Services.',
            'Toggle the switch to On.',
          ]),
          const SizedBox(height: 20.0),
          _buildTitle('iPhone or iPad (iOS 9) - Safari/Chrome/Etc.'),
          _buildList([
            'Tap the Settings application.',
            'Tap Privacy.',
            'Tap Location Services.',
            'Tap the browser you are using.',
            'Make sure the GPS setting states "allow while using the app".',
          ]),
          const Divider(color: Colors.red, thickness: 1.5),
          _buildTitle('Apple Desktop Devices (OS X Mountain Lion or later)'),
          _buildList([
            'Choose System Preferences from the Apple menu.',
            'Click the Security & Privacy icon in the System Preferences window.',
            'Click the Privacy tab.',
            'Unlock the padlock icon in the lower left and enter admin credentials.',
            'Select Location Services and enable them.',
          ]),
        ],
      ),
    );
  }

  Widget _buildAndroidSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('Android Devices'),
          _buildList([
            'Tap the Settings application.',
            'Tap Location.',
            'Tap Google Location Reporting.',
            'Tap Location Reporting.',
            'Toggle the switch to On.',
          ]),
          const Divider(color: Colors.red, thickness: 1.5),
          _buildTitle('Chrome Browser'),
          _buildList([
            'Open Chrome and tap the more button (three dots).',
            'Go to Settings > Site Settings > Location.',
            'Make sure Location is enabled.',
            'Find fuelcheck.co.zw in the list and allow location access.',
          ]),
          const Divider(color: Colors.red, thickness: 1.5),
          _buildTitle('Samsung Browser'),
          _buildList([
            'Open the browser and tap the more button (three dots).',
            'Go to Settings > Privacy.',
            'Enable location access by selecting the checkbox.',
          ]),
        ],
      ),
    );
  }

  Widget _buildDesktopSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('Windows Desktop - Chrome'),
          _buildList([
            'Open Chrome.',
            'Click the menu (three dots) and go to Settings > Privacy.',
            'Click Content Settings > Location.',
            'Enable location access for future requests.',
          ]),
          const Divider(color: Colors.red, thickness: 1.5),
          _buildTitle('Internet Explorer 9, 10, 11'),
          _buildList([
            'Open Control Panel and select Internet Options.',
            'Go to the Privacy tab.',
            'Uncheck "Never allow websites to request location".',
            'Click OK to save changes.',
          ]),
          const Divider(color: Colors.red, thickness: 1.5),
          _buildTitle('Mozilla Firefox'),
          _buildList([
            'Go to Tools > Page Info > Permissions.',
            'Change the setting for "Share Location".',
          ]),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16.0, height: 1.5),
      ),
    );
  }

  Widget _buildList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.circle, size: 8.0, color: Colors.red),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 16.0, height: 1.5),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
