import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/map_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 80,
                    color: Colors.red, // Adjust the icon color as needed
                  ),
                  SizedBox(width: 10), // Space between icon and text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FUEL',
                        style: TextStyle(
                          fontSize: 36, // Large text
                          fontWeight: FontWeight.bold, // Bold styling
                          color: Colors.black, // White text for visibility
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 4,
                              color: Colors.black
                                  .withOpacity(0.6), // Shadow effect
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'CHECKER',
                        style: TextStyle(
                          fontSize: 36, // Large text
                          fontWeight: FontWeight.bold, // Bold styling
                          color: Colors.black, // White text for visibility
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 4,
                              color: Colors.black
                                  .withOpacity(0.6), // Shadow effect
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20), // Space between the two rows
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.black, // Black circles
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
