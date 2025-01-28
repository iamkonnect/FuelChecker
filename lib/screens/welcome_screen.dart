import 'dart:math';
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importing the LoginScreen

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _colorAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Ensure navigation happens after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) { // Check if the widget is still mounted
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      });
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
            image: AssetImage('lib/assets/images/map_background.png'), // Updated map background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Logo
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  double bounce = 10 * sin(_controller.value * 2 * pi);
                  return Transform.translate(
                    offset: Offset(0, bounce),
                    child: child,
                  );
                },
                child: Image.asset(
                  'lib/assets/images/Fuelcheck logo 150by1.png', // Updated path
                  height: 200, // Adjust logo size as needed
                ),
              ),
              const SizedBox(height: 10), // Reduced spacing
              // Horizontal row of animated circles
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      // Zigzag motion
                      double offsetX = (index % 2 == 0 ? 1 : -1) *
                          10 *
                          sin(_controller.value * 2 * pi);
                      double offsetY = 10 * cos(_controller.value * 2 * pi);

                      return Transform.translate(
                        offset: Offset(offsetX, offsetY),
                        child: CircleAvatar(
                          radius: 12, // Increased radius to reduce overlap
                          backgroundColor: _colorAnimation.value,
                        ),
                      );
                    },
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
