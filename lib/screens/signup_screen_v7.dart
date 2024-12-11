import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importing the Login Screen

class SignUpScreenV7 extends StatefulWidget {
  const SignUpScreenV7({super.key});

  @override
  SignUpScreenV7State createState() => SignUpScreenV7State();
}

class SignUpScreenV7State extends State<SignUpScreenV7> {
  final TextEditingController countryCodeController = TextEditingController(); // Controller for country code
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _passwordStrength = '';
  Color _passwordStrengthColor = Colors.black;

  String evaluatePasswordStrength(String password) {
    if (password.length < 8) {
      _passwordStrengthColor = Colors.red;
      return 'Weak';
    } else if (password.contains(RegExp(r'[A-Z]')) &&
               password.contains(RegExp(r'[0-9]')) &&
               password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      _passwordStrengthColor = Colors.green;
      return 'Strong';
    } else {
      _passwordStrengthColor = Colors.orange;
      return 'Moderate';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()), // Navigate to Login Screen
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'lib/assets/images/logo-full-color-150-x-1.png',
                height: 100, // Adjust height as needed
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to Fuel Checker!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text('Register with', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: const Icon(Icons.facebook), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.apple), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.g_translate), onPressed: () {}),
                ],
              ),
              const Text('or', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _passwordStrength = evaluatePasswordStrength(value);
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Text(
                'Password Strength: $_passwordStrength',
                style: TextStyle(
                  color: _passwordStrengthColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Text field for country code
              TextField(
                controller: countryCodeController,
                decoration: const InputDecoration(
                  labelText: 'Country Code',
                  prefixIcon: Icon(Icons.flag),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Text field for phone number
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Removed the Sign Up button
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Remember me'),
                  Switch(
                    value: false,
                    onChanged: (value) {
                      // Handle remember me logic here
                    },
                    activeColor: const Color(0xFFDF2626),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
