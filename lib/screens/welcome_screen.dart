import 'package:flutter/material.dart';

import 'signup_screen_final_copy_updated_v3.dart'; // Importing the updated SignUpScreen

class WelcomeScreen extends StatelessWidget {
const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // Updated Logo
              Image.asset('lib/assets/images/logo-full-color-150-x-1.svg'), // Logo
const SizedBox(height: 20), // Space between logo and text
              Text(
                'FUEL CHECK',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Space between text and dots
              // Loading Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.black,
                    ),
                  );
                }),
              ),
              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpScreen()), // Updated reference
                  );
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
