import 'package:flutter/material.dart';

class OtpVerificationScreenV4 extends StatefulWidget {
  final String phoneNumber; // Add phoneNumber parameter

  const OtpVerificationScreenV4({super.key, required this.phoneNumber}); // Update constructor

  @override
  _OtpVerificationScreenV4State createState() => _OtpVerificationScreenV4State();
}

class _OtpVerificationScreenV4State extends State<OtpVerificationScreenV4> {
  final List<String> _otpCodes = List.filled(6, '');

  void _onOtpChanged(int index, String value) {
    setState(() {
      _otpCodes[index] = value;
    });
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).nextFocus();
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

  void _verifyOtp() {
    final enteredOtp = _otpCodes.join();
    if (enteredOtp == '123456') {
      // OTP is correct, proceed to the filter screen
      Navigator.pushReplacementNamed(context, '/filter_screen');
    } else {
      // OTP is incorrect, show a more detailed error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The OTP you entered is incorrect. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/map_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // OTP Verification Text
                const Text(
                  'OTP Verification',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text( // Display the phone number
                  'Please enter the codes sent to your phone: ${widget.phoneNumber}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => _onOtpChanged(index, value),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                // Enter Button
                ElevatedButton(
                  onPressed: _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDF2626),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 5,
                  ),
                  child: const Text('Enter'),
                ),
                const SizedBox(height: 20),
                // Back Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDF2626),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 5,
                  ),
                  child: const Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}