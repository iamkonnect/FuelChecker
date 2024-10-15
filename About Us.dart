import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AboutPage(),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(
                children: [
                  IconButton(
                    icon: Image.asset('./assets/arrow-left.svg'),
                    onPressed: () {},
                  ),
                  SizedBox(width: 20),
                  Text(
                    'About',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Did you know there can be a difference of 40 cents per litre between the cheapest and most expensive service station?',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Fuel Check gives you...',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Fuel Types',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 10),
              FuelTypeSection(title: 'Petrol', blends: [
                FuelBlend(
                  name: 'Blend E20',
                  description: 'A fuel blend of ethanol and unleaded petrol.',
                ),
              ]),
              SizedBox(height: 20),
              FuelTypeSection(title: 'Diesel', blends: [
                FuelBlend(
                  name: 'Diesel E50',
                  description: 'A fuel blend of Diesel...',
                ),
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            width: 200,
            height: 10,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class FuelTypeSection extends StatelessWidget {
  final String title;
  final List<FuelBlend> blends;

  FuelTypeSection({required this.title, required this.blends});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        ...blends.map(
          (blend) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Text(
                  blend.name,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    height: 1.5,
                    color: Color(0xFF000000).withOpacity(0.8),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    blend.description,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      height: 1.5,
                      color: Color(0xFF000000).withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FuelBlend {
  final String name;
  final String description;

  FuelBlend({required this.name, required this.description});
}
