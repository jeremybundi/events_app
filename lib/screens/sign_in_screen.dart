import 'package:flutter/material.dart';
import 'otp_verification_screen.dart';  // Import the OTP verification screen

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleSignIn() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Here you would send the username and password to your API to verify
    // If the user exists and the credentials are valid, an OTP is sent to their email

    // After sending OTP, navigate to the OTP verification screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPVerificationScreen(username: username),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSignIn,
              child: Text('Sign In'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigate to Sign Up screen
                  },
                  child: Text('Sign Up'),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to Forgot Password screen
                  },
                  child: Text('Forgot Password?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
