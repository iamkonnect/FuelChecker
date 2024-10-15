import 'package:flutter/material.dart';

void main() {
  runApp(SignUpApp());
}

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.red,
              height: 150,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white),
                  SizedBox(height: 20),
                  Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Text(
                    'Please register to enjoy our services',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ],
              ),
            ),
            // Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  buildInputField(label: 'Full Name', initialValue: 'Cornelius Nyahwa'),
                  buildInputField(label: 'Email', initialValue: 'cornyhawa@gmail.com'),
                  buildPasswordField(label: 'Password', hint: '••••'),
                  buildPasswordField(label: 'Confirm Password', hint: 'Enter your password'),
                  buildPhoneField(),
                  buildAgreementCheckbox(),
                  buildSignUpButton(),
                  buildFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField({required String label, String? initialValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xffa5a7ab)),
          ),
          SizedBox(height: 6),
          TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xfff3f4f6)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPasswordField({required String label, required String hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xffa5a7ab)),
              ),
              if (label == 'Password')
                Text(
                  'Strong',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
                ),
            ],
          ),
          SizedBox(height: 6),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(12.0),
              suffixIcon: Icon(Icons.visibility_off, color: Color(0xff787b82)),
              hintText: hint,
              hintStyle: TextStyle(color: Color(0xffd2d3d5)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xff0b1223)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phone Number',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xffa5a7ab)),
          ),
          SizedBox(height: 6),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xfff3f4f6)),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('+263', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black)),
                    SizedBox(width: 8),
                    VerticalDivider(width: 1, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAgreementCheckbox() {
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value) {}, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'I agree & accept all the terms & conditions.',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xff787b82)),
          ),
        ),
      ],
    );
  }

  Widget buildSignUpButton() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Color(0xffdf2626),
            padding: EdgeInsets.symmetric(horizontal: 140, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildFooter() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          'Have an account? Login',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff787b82)),
        ),
      ),
    );
  }
}
