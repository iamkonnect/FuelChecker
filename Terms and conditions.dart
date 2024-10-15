import 'package:flutter/material.dart';

void main() {
  runApp(TermsAndConditionsApp());
}

class TermsAndConditionsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Terms & Conditions',
      home: TermsAndConditionsPage(),
    );
  }
}

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Terms & Conditions",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFDF2626),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Please accept this terms first to enjoy the service(s).",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0B1223).withOpacity(0.45),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Thank you for using Fuel Checker! We're happy you're here. "
                  "Please read this Terms of Service agreement carefully before "
                  "accessing or using Fuel Checker. Because it is such an "
                  "important contract between us and our users, we have tried "
                  "to make it as clear as possible. For your convenience, we "
                  "have presented these terms in a short non-binding summary "
                  "followed by the full legal terms.",
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF787B82),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),
              Image.asset(
                './assets/logo-full-color-150-x-1.svg', // use correct image format if necessary
                width: 296,
                height: 239,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isAccepted,
                      onChanged: (value) {
                        setState(() {
                          _isAccepted = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'I agree & accept all the ',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF787B82),
                              ),
                            ),
                            TextSpan(
                              text: 'terms & conditions.',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFDF2626),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isAccepted ? () {} : null,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFDF2626),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text(
                  'Accept',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

