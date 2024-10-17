/* Log In.dart */
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log In Page',
      home: LogInPage(),
    );
  }
}

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool showPassword = false;
  final _emailOrUsernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Center(
                child: Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 48),
              buildTextField("Username or Email", _emailOrUsernameController),
              SizedBox(height: 16),
              buildPasswordField(),
              SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to the Sign Up page
                  },
                  child: Text(
                    "Don’t have an account? Sign Up",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFDF2626),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    ),
                    onPressed: () {
                      // Implement login logic here
                      // For example: navigate to dashboard if successful
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Logic to send reset password email
                    sendResetPasswordEmail(_emailOrUsernameController.text);
                  },
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFFBDBDBD),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: !showPassword,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFFBDBDBD),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          child: Text(
            showPassword ? 'Hide' : 'Show',
            style: TextStyle(
              color: Color(0xFF0B1223),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }

  void sendResetPasswordEmail(String emailOrUsername) {
    // Add the logic to send an email to reset password.
    // This typically involves checking if the input is a valid email
    // and then triggering a back-end service call to send the reset email.
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Password Reset"),
        content: Text("An email has been sent to reset your password."),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
