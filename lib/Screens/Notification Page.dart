import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationsPage(),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('./assets/arrow-left.svg'),
          onPressed: () {
            // Handle back navigation
          },
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFF7F7F7),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black12),
                ),
              ),
              child: Text(
                'Manage Notifications',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Favourite Stations Alert',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Add your favourite station on the tab first',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              trailing: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 10,
        width: 200,
        color: Colors.black,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 20),
      ),
    );
  }
}
