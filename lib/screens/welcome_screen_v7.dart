import 'package:flutter/material.dart';

import 'login_screen.dart'; // Importing the new LoginScreen
import 'signup_screen_v7.dart'; // Importing the updated SignUpScreenV7
import 'terms_and_conditions_screen.dart'; // Importing the TermsAndConditionsScreen

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color shadowColor = Colors.black.withOpacity(0.6);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/map_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 40,
              right: 20,
              child: Column(
                children: [
                  // Updated Logo
                  Image.asset('lib/assets/images/logo-full-color-150-x-1.png', height: 300), // Logo
                  const SizedBox(height: 20), // Space between logo and text
                  // Removed the text "FUEL CHECK"
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
                        MaterialPageRoute(builder: (context) => const SignUpScreenV7()), // Updated reference
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDF2626),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 5,
                    ),
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 20), // Space between sign-up and login buttons
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()), // New reference
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDF2626),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 5,
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20), // Space between login and next buttons
                  ElevatedButton(
                    onPressed: () {
                      // Check if the user is new
                      bool isNewUser = true; // Replace with actual logic to check if the user is new
                      if (isNewUser) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TermsAndConditionsScreen()), // Navigate to terms and conditions screen
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreenV7()), // Navigate to sign up screen
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDF2626),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 5,
                    ),
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
