import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';
import 'signup_screen_v7.dart';

class VerificationScreen extends StatefulWidget {
  final bool isVerified;
  final String email;

  const VerificationScreen({super.key, required this.isVerified, required this.email});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String? _storedOTP;
  DateTime? _otpCreatedAt;
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isLoading = false;
  bool _isResending = false;
  String _errorMessage = '';
  bool _isOTPRetrieved = false;
  int _resendCooldown = 0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _retrieveOTPFromFirestore();
  }

  Future<void> _retrieveOTPFromFirestore() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final usersCollection = _firestore.collection('users');
      final querySnapshot = await usersCollection
          .where('email', isEqualTo: widget.email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();
        setState(() {
          _storedOTP = userData['otp']?.toString();
          _otpCreatedAt = userData['otpCreatedAt'] != null 
              ? DateTime.parse(userData['otpCreatedAt']) 
              : null;
          _isOTPRetrieved = true;
          _isLoading = false;
        });
        
        if (_storedOTP == null) {
          setState(() {
            _errorMessage = 'No OTP found. Please sign up again.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'User not found. Please sign up again.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error retrieving OTP. Please try again.';
        _isLoading = false;
      });
    }
  }

  bool _isOTPExpired() {
    if (_otpCreatedAt == null) return false;
    final expirationTime = _otpCreatedAt!.add(const Duration(minutes: 10));
    return DateTime.now().isAfter(expirationTime);
  }

  void _submitOTP() {
    if (_storedOTP == null) {
      setState(() {
        _errorMessage = 'OTP not loaded. Please wait or try again.';
      });
      return;
    }

    if (_isOTPExpired()) {
      setState(() {
        _errorMessage = 'OTP has expired. Please request a new one.';
      });
      return;
    }

    String enteredOTP = _otpControllers.map((c) => c.text).join();
    
    if (enteredOTP == _storedOTP) {
      setState(() {
        _errorMessage = '';
        _isLoading = true;
      });
      
      _updateVerificationStatus();
      
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      });
    } else {
      setState(() {
        _errorMessage = 'Invalid OTP code. Please try again.';
      });
    }
  }

  Future<void> _updateVerificationStatus() async {
    try {
      final usersCollection = _firestore.collection('users');
      final querySnapshot = await usersCollection
          .where('email', isEqualTo: widget.email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({
          'isVerified': true,
        });
      }
    } catch (e) {
      // Silently handle error - user can still proceed
    }
  }

  Future<void> _resendOTP() async {
    if (_resendCooldown > 0) return;

    setState(() {
      _isResending = true;
    });

    try {
      // Generate new OTP
      String newOTP = _generateOTP();
      
      // Update OTP in Firestore
      final usersCollection = _firestore.collection('users');
      final querySnapshot = await usersCollection
          .where('email', isEqualTo: widget.email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({
          'otp': newOTP,
          'otpCreatedAt': DateTime.now().toIso8601String(),
        });

        // Clear entered OTP fields
        for (var controller in _otpControllers) {
          controller.clear();
        }
        _focusNodes[0].requestFocus();

        setState(() {
          _storedOTP = newOTP;
          _otpCreatedAt = DateTime.now();
          _errorMessage = '';
          _resendCooldown = 60; // 60 seconds cooldown
        });

        // Start cooldown timer
        _startResendCooldown();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to resend OTP. Please try again.';
      });
    } finally {
      setState(() {
        _isResending = false;
      });
    }
  }

  String _generateOTP() {
    final random = Random();
    String otp = '';
    for (int i = 0; i < 6; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }

  void _startResendCooldown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendCooldown > 0) {
        setState(() {
          _resendCooldown--;
        });
        _startResendCooldown();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/Fuelcheck logo 150by1.png'),
              const SizedBox(height: 20),
              Text(
                'Enter the OTP code sent to your email: ${widget.email}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              if (_isOTPExpired())
                const Text(
                  'OTP has expired. Please request a new one.',
                  style: TextStyle(color: Colors.orange, fontSize: 14),
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            _focusNodes[index + 1].requestFocus();
                          }
                          if (value.isEmpty && index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(double.infinity, 51),
                ),
                onPressed: _isLoading ? null : _submitOTP,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
              ),
              const SizedBox(height: 10),
              // Resend OTP Button
              TextButton(
                onPressed: (_isResending || _resendCooldown > 0) ? null : _resendOTP,
                child: _isResending
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        _resendCooldown > 0
                            ? 'Resend OTP in ${_resendCooldown}s'
                            : 'Resend OTP',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _resendCooldown > 0 ? Colors.grey : Colors.red),
                      ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreenV7()),
                  );
                },
                child: const Text(
                  'Back to Sign Up',
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
    );
  }
}
