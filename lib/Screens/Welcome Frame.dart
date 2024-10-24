import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80), // Space for status bar
              Text(
                'Welcome',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Register with',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF2D3748),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(asset: 'assets/facebook.svg'),
                  SizedBox(width: 16),
                  SocialButton(asset: 'assets/apple.svg'),
                  SizedBox(width: 16),
                  SocialButton(asset: 'assets/google.svg'),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'or',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFFA0AEC0),
                ),
              ),
              SizedBox(height: 20),
              InputField(label: 'Name', hintText: 'Your full name'),
              InputField(label: 'Email', hintText: 'Your email address'),
              InputField(label: 'Password', hintText: 'Your password', obscureText: true),
              SizedBox(height: 20),
              RememberMeSwitch(),
              SizedBox(height: 20),
              SignUpButton(),
              SizedBox(height: 20),
              Text(
                'Already have an account? Sign in',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFFA0AEC0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String asset;

  SocialButton({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(asset),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;

  InputField({
    required this.label,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF2D3748),
          ),
        ),
        SizedBox(height: 4),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xFFE2E8F0)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class RememberMeSwitch extends StatefulWidget {
  @override
  _RememberMeSwitchState createState() => _RememberMeSwitchState();
}

class _RememberMeSwitchState extends State<RememberMeSwitch> {
  bool isRemembered = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: isRemembered,
          onChanged: (value) {
            setState(() {
              isRemembered = value;
            });
          },
          activeColor: Colors.red,
        ),
        Text(
          'Remember me',
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xFF2D3748),
          ),
        ),
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Sign up action
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFDF2626),
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'SIGN UP',
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
