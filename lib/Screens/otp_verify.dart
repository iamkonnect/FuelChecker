import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OTPVerificationScreen(),
    );
  }
}

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = 24.0;

    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              TextFieldWithLabel(label: 'Full Name', value: 'Cornelius Nyahwa'),
              TextFieldWithLabel(label: 'Email', value: 'cornyhawa@gmail.com'),
              SizedBox(height: 40),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFD0DCCA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        './assets/lock-key.png', // Adjust the path if needed
                        width: 32,
                        height: 32,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "OTP Verification",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "The OTP code will be sent to you through the method you select",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF75788D),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 48),
                    OTPButton(
                      iconPath: './assets/device-mobile.png', // Adjust the path if needed
                      label: "Send OTP via SMS",
                      color: Color(0xFFEC1F1F),
                      onPressed: () {},
                    ),
                    SizedBox(height: 16),
                    OTPButton(
                      iconPath: './assets/envelope-simple.png', // Adjust the path if needed
                      label: "Send OTP via Email",
                      color: Color(0xFFD0DCCA),
                      textColor: Color(0xFF222741),
                      onPressed: () {},
                    ),
                    SizedBox(height: 16),
                    BackButton(onPressed: () {
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWithLabel extends StatelessWidget {
  final String label;
  final String value;

  const TextFieldWithLabel({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFFA5A7AB),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.symmetric(vertical: 11, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFF3F4F6)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: Color(0xFF1E232E),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}

class OTPButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const OTPButton({super.key, 
    required this.iconPath,
    required this.label,
    required this.color,
    this.textColor = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Image.asset(
        iconPath,
        width: 24,
        height: 24,
      ),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor, backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
      child: Text(
        'Back',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
