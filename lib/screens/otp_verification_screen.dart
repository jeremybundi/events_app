import 'package:flutter/material.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String username;

  OTPVerificationScreen({required this.username});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  void _handleVerifyOTP() {
    final otp = _otpController.text;
    final username = widget.username;

    // Here you would verify the OTP using your API
    // If the OTP is correct, log the user in

    // If successful, navigate to the main screen or dashboard
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'Enter OTP'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleVerifyOTP,
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
