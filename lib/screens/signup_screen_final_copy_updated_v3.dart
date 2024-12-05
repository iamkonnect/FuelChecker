import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Register with', style: TextStyle(fontSize: 18)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: const Icon(Icons.facebook), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.apple), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.g_translate), onPressed: () {}),
                ],
              ),
              const Text('or', style: TextStyle(fontSize: 16)),
              const TextField(
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              const TextField(
                decoration: InputDecoration(labelText: 'Email'),
              ),
              const TextField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const TextField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: <String>['+263', '+1', '+44'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Phone Number'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Sign up logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('Sign Up'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Remember me'),
                  Switch(value: false, onChanged: (value) {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}