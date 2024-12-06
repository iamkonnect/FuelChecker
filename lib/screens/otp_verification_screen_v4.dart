import 'package:flutter/material.dart';

class OtpVerificationScreenV4 extends StatelessWidget {
  final String phoneNumber; // Add phoneNumber parameter

  const OtpVerificationScreenV4({super.key, required this.phoneNumber}); // Update constructor

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
                  'Please enter the codes sent to your phone: $phoneNumber',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 200,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.length == 1 && index < 3) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                // Enter Button
ElevatedButton(
  onPressed: () {
    // Logic to verify OTP
  },
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
