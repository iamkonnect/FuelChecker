import 'package:flutter/material.dart';
import 'signup_screen_v7.dart'; // Importing the Sign Up Screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.length >= 8 &&
           password.contains(RegExp(r'[A-Z]')) &&
           password.contains(RegExp(r'[0-9]')) &&
           password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
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
              // Logo
              Image.asset('lib/assets/images/logo-full-color-150-x-1.png', height: 300),
              const SizedBox(height: 20),
              // Removed the text "FUEL CHECK"
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: const OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        if (!isValidEmail(email)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid email format')),
                          );
                          return;
                        }

                        if (!isValidPassword(password)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Password must be at least 8 characters long and include uppercase letters, numbers, and special characters.')),
                          );
                          return;
                        }

                        // Simulate successful login for demonstration
                        Navigator.pushNamed(context, '/fuel_type_selection');
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login successful!')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDF2626),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 5,
                      ),
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot_password');
                      },
                      child: const Text(
                        'Forgot your password? Click here',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreenV7()), // Navigate to Sign Up Screen
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.red),
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
