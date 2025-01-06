import 'package:flutter/material.dart';
import 'dart:async';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // Duration of the animation
    )..repeat(reverse: true);

    // Define a bounce animation
    _bounceAnimation = Tween<double>(begin: 0.0, end: -15.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);

    // Automatically navigate to the login screen after a delay
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              // Logo with animation
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _bounceAnimation.value),
                    child: child,
                  );
                },
                child: Image.asset(
                  'lib/assets/images/logo-full-color-150-x-1.png',
                  height: 150, // Adjust logo size as needed
                ),
              ),
              const SizedBox(height: 20), // Space between logo and dots
              // Animated loading dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      // Offset each dot's animation for a wave-like effect
                      double offset =
                          (index * 0.2) % 1.0; // Staggered delay for dots
                      double bounce = Curves.easeInOut
                          .transform(((_controller.value + offset) % 1.0));
                      return Transform.translate(
                        offset: Offset(0, -bounce * 10),
                        child: child,
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.black,
                      ),
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
