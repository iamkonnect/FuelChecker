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
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size(328, 51), // Set the button size
              ),
              child: const Text('Send Reset Email'),
            ),
          ],
        ),
      ),
      // Removed BottomNavigationBar for account recovery focus
    );
  }
}
