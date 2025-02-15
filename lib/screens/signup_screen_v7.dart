import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'verification_screen.dart';

class SignUpScreenV7 extends StatefulWidget {
  const SignUpScreenV7({super.key});

  @override
  SignUpScreenV7State createState() => SignUpScreenV7State();
}

class SignUpScreenV7State extends State<SignUpScreenV7> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+263');
  final TextEditingController _phoneController = TextEditingController();

  void _signUp() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    if (!EmailValidator.validate(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email format!')),
      );
      return;
    }

    // Handle sign-up logic here (e.g., API call)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VerificationScreen(isVerified: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                const Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 20),
                const Text('Register with',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 20),
                // Social Media Icons
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10, // Reduced the spacing between icons
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                          10), // Reduced padding inside the icon container
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey), // Add a border with a color
                        borderRadius: BorderRadius.circular(
                            10), // Slightly rounded corners
                      ),
                      child: Image.asset(
                        'assets/images/Facebook Icon.png',
                        width: 24, // Set a consistent width
                        height: 24, // Set a consistent height
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        'assets/images/apple icon logo.png',
                        width: 24, // Set a consistent width
                        height: 24, // Set a consistent height
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        'assets/images/Black Google Icon.png',
                        width: 24, // Set a consistent width
                        height: 24, // Set a consistent height
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Full Name TextField
                TextField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                      labelText: 'Full Name', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                // Email TextField
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                // Password TextField
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Confirm Password TextField
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Phone Number Input
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: _countryCodeController,
                        maxLength: 3, // Limit to 3 characters
                        decoration: InputDecoration(
                          labelText: 'Country Code',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Space between the fields
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _phoneController,
                        maxLength: 10, // Limit to 10 characters
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Sign Up Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: const Size(328, 51),
                  ),
                  onPressed: _signUp,
                  child: const Text('Sign Up',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                const SizedBox(height: 20),
                // Login TextButton
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to the login screen
                  },
                  child: const Text(
                    "Already Got an account? Login",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
