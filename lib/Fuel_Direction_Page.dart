import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Station Map',
      home: SearchMapPage(),
    );
  }
}

class SearchMapPage extends StatelessWidget {
  const SearchMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 44,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
          color: Colors.black,
        ),
      ),
      backgroundColor: Color(0xFFF7F7F7),
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                './assets/rectangle-1-2.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 16,
            right: 16,
            child: Column(
              children: [
                SearchFields(),
                SizedBox(height: 20),
                FilterButton(),
                SizedBox(height: 400),
                InformationCard(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class SearchFields extends StatelessWidget {
  const SearchFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.location_on, color: Colors.black),
              SizedBox(width: 10),
              Expanded(
                child: Text('Current Location',
                    style: TextStyle(fontSize: 16)),
              ),
              IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {},
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            children: [
              Icon(Icons.location_on, color: Colors.black),
              SizedBox(width: 10),
              Expanded(
                child: Text('Puma Petroleum, Harare',
                    style: TextStyle(fontSize: 16)),
              ),
              IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {},
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFEEEEEE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.filter_alt, color: Colors.black),
          SizedBox(width: 10),
          Text('Filter: 500m Detour', style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}

class InformationCard extends StatelessWidget {
  const InformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Blend E5 based on Search Pricing',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset('./assets/rectangle-6.svg', width: 60),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("PUMA Westgate"),
                  Text("6XQH+57M, Harare, Zimbabwe"),
                  Text("Open 24 Hrs"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 4.0,
      shape: CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset('./assets/image-2.svg', width: 25),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset('./assets/image-10.svg', width: 25),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset('./assets/image-6.svg', width: 25),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset('./assets/image-8.svg', width: 25),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset('./assets/image-4.svg', width: 25),
            ),
          ],
        ),
      ),
    );
  }
}
