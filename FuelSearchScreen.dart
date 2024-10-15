import 'package:flutter/material.dart';

void main() {
  runApp(FuelSearchApp());
}

class FuelSearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FuelSearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FuelSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    './assets/group-17.svg',
                    height: 54,
                    width: 57,
                  ),
                  Image.asset(
                    './assets/group-18.svg',
                    height: 58,
                    width: 54,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find a low cost',
                      style: TextStyle(
                        fontFamily: 'Agency FB',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Color(0xFF0B1223).withOpacity(0.73),
                      ),
                    ),
                    Text(
                      'Fuel Nearby',
                      style: TextStyle(
                        fontFamily: 'Agency FB',
                        fontWeight: FontWeight.w700,
                        fontSize: 39,
                        color: Color(0xFFDF2626),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Puma Petroleum',
                              hintStyle: TextStyle(
                                fontFamily: 'Agency FB',
                                fontWeight: FontWeight.w700,
                                fontSize: 21,
                                color: Color(0xFF0B1223),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Image.asset(
                          './assets/iconly-light-filter.svg',
                          height: 32,
                          width: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Search results',
                  style: TextStyle(
                    fontFamily: 'Agency FB',
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    color: Color(0xFF0B1223).withOpacity(0.73),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                padding: EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  return FuelCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FuelCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    './assets/img-20240207-wa-0018-1.svg',
                    height: 25.06,
                    width: 22,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Puma Petroleum',
                    style: TextStyle(
                      fontFamily: 'Agency FB',
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Color(0xFF0B1223),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '3 km away',
                    style: TextStyle(
                      fontFamily: 'Agency FB',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFFDF2626),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Blend E5',
                    style: TextStyle(
                      fontFamily: 'Agency FB',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0xFF0B1223).withOpacity(0.73),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$1.39',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xFF0B1223).withOpacity(0.73),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Diesel',
                    style: TextStyle(
                      fontFamily: 'Agency FB',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0xFF0B1223).withOpacity(0.73),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$1.59',
                    style: TextStyle(
                      fontFamily: 'Agency FB',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF0B1223).withOpacity(0.73),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 12.0),
                      child: Text(
                        'Direction',
                        style: TextStyle(
                          fontFamily: 'Agency FB',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
