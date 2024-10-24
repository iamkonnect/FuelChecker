import 'package:flutter/material.dart';

void main() {
  runApp(SignUpApp());
}

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        fontFamily: 'Manrope',
      ),
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffdf2626),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('./assets/arrow-left.png'),
          onPressed: () {
            // Implement navigation
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xffdf2626),
            height: 117,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Please register to enjoy our services",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 80,
            child: ListView(
              padding: EdgeInsets.all(24.0),
              children: [
                buildInputField("Full Name", "Cornelius Nyahwa"),
                buildInputField("Email", "cornyhawa@gmail.com"),
                buildPasswordInputField("Password", "••••", "Strong"),
                buildInputField("Confirm Password", "Enter your password"),
                buildPhoneInputField("Phone Number", "+263", "734 578 011"),
                SizedBox(height: 24.0),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffdf2626),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                    ),
                    onPressed: () {
                      // Implement sign up
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Implement login navigation
                    },
                    child: Text(
                      "Have an account? Login",
                      style: TextStyle(
                        color: Color(0xff787b82),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputField(String label, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xffa5a7ab),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 11.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Color(0xfff3f4f6),
              ),
            ),
            child: Text(
              hintText,
              style: TextStyle(
                color: Color(0xff1e232e),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPasswordInputField(String label, String hintText, String strength) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: Color(0xffa5a7ab),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Image.asset('./assets/icon-outline.png', width: 16, height: 16),
                ],
              ),
              Text(
                strength,
                style: TextStyle(
                  color: Color(0xff0b1223),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Color(0xff0b1223),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hintText,
                  style: TextStyle(
                    color: Color(0xff1e232e),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Image.asset('./assets/clarity-eye-hide-line.png', width: 20, height: 20),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 2.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget buildPhoneInputField(String label, String code, String phone) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xffa5a7ab),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Color(0xfff3f4f6),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    code,
                    style: TextStyle(
                      color: Color(0xff1e232e),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                VerticalDivider(),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    phone,
                    style: TextStyle(
                      color: Color(0xff1e232e),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
