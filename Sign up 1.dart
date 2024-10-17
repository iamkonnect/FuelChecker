import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FuelCheckPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FuelCheckPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              './assets/rectangle-1.svg', // Ensure the image is in your assets
              fit: BoxFit.cover,
            ),
          ),
          // Logo and title
          Positioned(
            top: 189,
            left: -1,
            right: -1,
            child: Image.asset(
              './assets/logo-full-color-150-x-1.svg',
              width: 375,
              height: 299,
            ),
          ),
          // Dots alignment at the bottom
          Positioned(
            bottom: 350,
            left: 95,
            right: 95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return CircleAvatar(
                  radius: 9,
                  backgroundColor: Colors.black,
                );
              }),
            ),
          ),
          // Status Bar
          Positioned(
            top: 0,
            left: -1,
            right: 359,
            height: 44,
            child: Image.asset(
              './assets/i-os-status-bar-black.svg',
            ),
          ),
          // Login Form
          Positioned(
            left: 40,
            right: 40,
            bottom: 100,
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, // To hide the password
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _submitLogin(context),
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
          // Line at the bottom
          Positioned(
            bottom: 10,
            left: 86,
            child: Container(
              width: 200,
              height: 10,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Function to validate email format
  bool _isValidEmail(String email) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  // Updated function to include email validation
  void _submitLogin(BuildContext context) {
    String email = emailController.text;
    String password = passwordController.text;

    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a valid email address'),
      ));
      return;
    }

    if (email.isNotEmpty && password.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login successful'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter both email and password'),
      ));
    }
  }
}
