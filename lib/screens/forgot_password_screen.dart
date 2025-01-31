import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/mapbackground.png'), // Updated path
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text('Forgot Password Content Here'),
        ),
      ),
    );
  }
}
