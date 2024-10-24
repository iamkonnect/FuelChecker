import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TermsAndConditionsPage(),
    );
  }
}

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: Color(0xFFDF2626),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Please accept this terms first to enjoy the service(s).',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Color(0xFF0B1223).withOpacity(0.45),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Thank you for using Fuel Checker! We\'re happy you\'re here. Please read this Terms of Service agreement carefully before accessing or using Fuel Checker. Because it is such an important contract between us and our users, we have tried to make it as clear as possible. For your convenience, we have presented these terms in a short non-binding summary followed by the full legal terms.',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF787B82),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Image.asset('assets/logo-full-color-150-x-1.svg', height: 239, width: 296),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'I agree & accept all the ',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xFF787B82),
                        ),
                        children: [
                          TextSpan(
                            text: 'terms & conditions.',
                            style: TextStyle(
                              color: Color(0xFFDF2626),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDF2626),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  ),
                  child: Text(
                    'Accept',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
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
