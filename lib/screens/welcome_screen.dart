import 'package:flutter/material.dart';

import 'login_screen.dart'; // Importing the LoginScreen
// Importing the SignUpScreenV7
// Importing the TermsAndConditionsScreen

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/map_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'lib/assets/images/logo-full-color-150-x-1.png',
                height: 300, // Adjust logo size as needed
              ),
              const SizedBox(height: 2), // Margin between logo and dots
              // Horizontal dotted circle row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.black, // Dots color
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
