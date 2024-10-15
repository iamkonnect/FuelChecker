import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Center',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      ),
      home: const NotificationCenterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotificationCenterPage extends StatelessWidget {
  const NotificationCenterPage({Key? key}) : super(key: key);

  Widget _buildNotificationCard(String assetName, String content) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/$assetName'),
          radius: 20.0,
        ),
        title: Text(
          content,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.5,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16.0),
              const Text(
                'Wednesday, 7 February',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0B1223),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4.0),
              const Text(
                '9:41',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Notification Centre',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0B1223),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView(
                  children: [
                    _buildNotificationCard(
                      'image-13.svg',
                      'Price Increase at Puma from \$8.50 to \$8.70',
                    ),
                    _buildNotificationCard(
                      'image-12.svg',
                      'Price Increase at Total Energies from \$8.50 to \$8.60',
                    ),
                    _buildNotificationCard(
                      'rectangle-6-4.svg',
                      'Price Decrease at ENGEN from \$8.50 to \$8.20',
                    ),
                    _buildNotificationCard(
                      'hp-petrol-pump-nandigama-krishna-petrol-pumps-zvw-318-o-7-xm-1.svg',
                      'Price Increase at Energy Park from \$8.10 to \$8.40',
                    ),
                    _buildNotificationCard(
                      'image-11.svg',
                      'Daily at REDAN at \$8.20 Petrol & \$8.45 Diesel',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
