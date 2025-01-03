import 'package:flutter/material.dart'; // Importing the Flutter material package
import 'otp_verification_screen_v4.dart'; // Importing the OTP verification screen
import 'package:email_validator/email_validator.dart'; // Importing email validator package

class SignUpScreenV7 extends StatefulWidget {
  const SignUpScreenV7({super.key});

  @override
  SignUpScreenV7State createState() => SignUpScreenV7State();
}

class SignUpScreenV7State extends State<SignUpScreenV7> {
  bool _obscureText = true; // To toggle password visibility

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
  Color _passwordStrengthColor = Colors.black;
  String _passwordStrength = '';
  bool _rememberMe = false; // Changed to bool for state management
  String? _selectedCountryCode;

  String evaluatePasswordStrength(String password) {
    if (password.length < 4) {
      _passwordStrengthColor = Colors.red;
      _passwordStrength = 'Weak';
    } else if (password.length < 8) {
      _passwordStrengthColor = Colors.orange; // Yellowish
      _passwordStrength = 'Moderate';
    } else if (password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      _passwordStrengthColor = Colors.green;
      _passwordStrength = 'Strong';
    } else {
      _passwordStrengthColor = Colors.orange; // Default to moderate
      _passwordStrength = 'Moderate';
    }
    return _passwordStrength;
  }

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
    // Include country code and phone number in the sign-up logic
    // Navigate to OTP screen after successful sign-up
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OtpVerificationScreenV4(phoneNumber: _phoneController.text),
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
            Navigator.pop(context); // Go back to the previous screen
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black, // Set the icon color to black
          ),
        ),
        // Removed title for cleanliness
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
              children: <Widget>[
                const SizedBox(height: 20),
                const Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black), // Increased size and bold
                ),
                const SizedBox(height: 20),
                const Text('Register with',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 20),
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
                        'lib/assets/images/Facebook Icon.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        'lib/assets/images/apple icon logo.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        'lib/assets/images/Black Google Icon.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                const Text('or',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                const SizedBox(height: 20),
                SizedBox(
                  width: 328,
                  child: TextField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 328,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 328,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Align to the center
                  children: [
                    const SizedBox(width: 10), // Align with input fields
                    for (int i = 0; i < 3; i++)
                      Container(
                        width: 40, // Adjusted width for better visibility
                        height: 2, // Increased height for better visibility
                        color: _passwordStrengthColor == Colors.red
                            ? Colors.red
                            : Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                      ),
                    for (int i = 0; i < 1; i++)
                      Container(
                        width: 40, // Adjusted width for better visibility
                        height: 2, // Increased height for better visibility
                        color: _passwordStrengthColor == Colors.orange
                            ? Colors.orange
                            : Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                      ),
                    for (int i = 0; i < 3; i++)
                      Container(
                        width: 40, // Adjusted width for better visibility
                        height: 2, // Increased height for better visibility
                        color: _passwordStrengthColor == Colors.green
                            ? Colors.green
                            : Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 328,
                  child: TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the row
                  children: [
                    SizedBox(
                      width: 100, // Adjusted width for the Code input field
                      child: TextField(
                        controller: _countryCodeController,
                        decoration: InputDecoration(
                          labelText: 'Code',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width:
                            5), // Reduced space between fields for better alignment
                    SizedBox(
                      width:
                          210, // Increased width for the Phone Number input field
                      child: TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: const Size(328, 51), // Set the button size
                  ),
                  onPressed: _signUp,
                  child: const Text('Sign Up',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                const SizedBox(
                    height: 20), // Spacing before the Remember Me section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Switch(
                      value:
                          _rememberMe, // Use the state variable for the switch
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value; // Update the state when toggled
                        });
                      },
                      activeColor:
                          Colors.red, // Color when the switch is active
                      inactiveTrackColor:
                          Colors.white, // Set inactive track color to white
                      inactiveThumbColor:
                          Colors.grey, // Set inactive thumb color to grey
                    ),
                    const SizedBox(width: 10), // Space between switch and text
                    const Text(
                      'Remember Me',
                      style: TextStyle(
                        color: Colors.black, // Text color
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                    height:
                        20), // Additional spacing after the Remember Me section
              ],
            ),
          ),
        ),
      ),
    );
  }
}
