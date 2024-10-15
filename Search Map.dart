import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              './assets/rectangle-1-2.svg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              // Status Bar
              Container(
                height: 44,
                color: Colors.black,
              ),
              // Search and Filter
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              './assets/iconly-light-arrow-left-2.svg',
                            ),
                            onPressed: () {},
                          ),
                          Expanded(
                            child: Text(
                              "Current Location",
                              style: TextStyle(
                                  fontFamily: 'Inter', fontSize: 16),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Puma Petroleum, Harare",
                              style: TextStyle(
                                  fontFamily: 'Inter', fontSize: 16),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.filter_list),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Map
              Expanded(
                child: Image.asset(
                  './assets/rectangle-1.svg',
                  fit: BoxFit.cover,
                ),
              ),
              // Info and Pricing
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image.asset('./assets/image-2.svg', width: 25, height: 25),
                        SizedBox(height: 8),
                        Text("Trends", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('./assets/image-10.svg', width: 25, height: 25),
                        SizedBox(height: 8),
                        Text("My Trip", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('./assets/image-6.svg', width: 25, height: 25),
                        SizedBox(height: 8),
                        Text("Nearby", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('./assets/image-8.svg', width: 25, height: 25),
                        SizedBox(height: 8),
                        Text("Favourite", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('./assets/image-4.svg', width: 25, height: 25),
                        SizedBox(height: 8),
                        Text("Settings", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Info Overlay
          Positioned(
            bottom: 128,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      './assets/image-13.svg',
                      width: 34.35,
                      height: 54.1,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Blend E5 based on Search Pricing",
                            style: TextStyle(
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          Text(
                            "PUMA Westgate\n6XQH+57M, Harare, Zimbabwe\nOpen 24 Hrs",
                            style: TextStyle(
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      "\$1.34",
                      style:
                          TextStyle(fontFamily: 'Inter', fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
