import 'package:flutter/material.dart';

void main() {
  runApp(FuelCheckApp());
}

class FuelCheckApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Check',
      home: FuelCheckPage(),
    );
  }
}

class FuelCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 44),  // Status Bar height
                  Image.asset(
                    './assets/logo-full-color-150-x-1.svg',
                    width: 150,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Please select your Fuel Type',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xFFF3F4F6), width: 1),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration.collapsed(hintText: ''),
                      items: [
                        DropdownMenuItem(
                          value: 'Diesel',
                          child: Text('Diesel'),
                        ),
                        DropdownMenuItem(
                          value: 'Blend E5',
                          child: Text('Blend E5'),
                        ),
                      ],
                      hint: Text(
                        'Choose your fuel type',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0x801E232E),
                        ),
                      ),
                      onChanged: (String? newValue) {},
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Your preferred fuel type will be used to send notifications. '
                    'You can configure and make adjustments on your fuel types and brand '
                    'filtering at anytime in these settings.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.625,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDF2626),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      // Navigate to the fuel map page
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Image.asset(
                    './assets/rectangle-9.svg',
                    width: 100,
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
