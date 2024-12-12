import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importing the LoginScreen

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color shadowColor = Colors.black.withOpacity(0.6);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.push(
              context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
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
          child: Stack(
            children: [
              Positioned(
                top: 40,
                right: 20,
                child: Column(
                  children: [
                    // Updated Logo
                    Center(
                      child: Image.asset('lib/assets/images/logo-full-color-150-x-1.png', height: 300), // Logo
                    ),
                    const SizedBox(height: 20), // Space between logo and text
                    // Removed the text "FUEL CHECK"
                    const SizedBox(height: 20), // Space between text and dots
                    // Loading Dots
                    Center(
                      child: Row(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
