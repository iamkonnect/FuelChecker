import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

// Remove the underscore to make this class public
class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/logo-full-color-150-x-1.png',
              height: 300, // Adjust height as needed
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Enter your email to reset your password',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text;
                
                if (email.isEmpty) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter your email address')),
                    );
                  }
                  return;
                }

                try {
                  // TODO: Replace with actual email sending when SMTP credentials are available
                  // For now, simulate email sending
                  await Future.delayed(const Duration(seconds: 1));
                  
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password reset email sent to $email')),
                    );
                    Navigator.pop(context);
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to send password reset email. Please try again later.')),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDF2626),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 5,
              ),
              child: const Text('Send Reset Email'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/Favourites.png')),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/Trends.png')),
            label: 'Trends',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/my trips.png')),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/nearby.png')),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/Settings.png')),
            label: 'Settings',
          ),
        ],
        currentIndex: 0, // Set the current index based on your logic
        selectedItemColor: const Color(0xFFDF2626), // Change selected color
        unselectedItemColor: Colors.black, // Default color
        onTap: (index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              // Navigate to Home
              break;
            case 1:
              // Navigate to Favorites
              break;
            case 2:
              // Navigate to Trends
              break;
            case 3:
              // Navigate to My Trips
              break;
            case 4:
              // Navigate to Nearby
              break;
            case 5:
              // Navigate to Settings
              break;
          }
        },
      ),
    );
  }
}