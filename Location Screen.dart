import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Ensure your pubspec.yaml has flutter_webview_plugin added

void main() {
  runApp(LocationApp());
}

class LocationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationPage(),
    );
  }
}

class LocationPage extends StatelessWidget {
  final String googleMapsUrl =
      "https://www.google.com/maps/@-17.8207784,31.0178917,13z?entry=ttu&g_ep=EgoyMDI0MTAxNC4wIKXMDSoASAFQAw%3D%3D"; // URL containing the overlay for map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: googleMapsUrl,
              javascriptMode: JavascriptMode.unrestricted,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 81),
                Image.asset(
                  './assets/image-6.png',
                  width: 202.44,
                  height: 220,
                ),
                SizedBox(height: 52),
                Text(
                  "Location Services",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36.0),
                  child: Text(
                    "Access to your location to improve location searches and estimate travel distance.",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 4, backgroundColor: Colors.black),
                    SizedBox(width: 8),
                    CircleAvatar(radius: 4, backgroundColor: Colors.black),
                    SizedBox(width: 8),
                    CircleAvatar(radius: 4, backgroundColor: Colors.orange),
                  ],
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFDF2626),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  ),
                  onPressed: () {
                    // Functionality to navigate or perform an action
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  './assets/rectangle-9.png',
                  width: 200,
                  height: 10,
                ),
                SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
