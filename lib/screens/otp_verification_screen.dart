import 'package:demo_app/screens/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_app_bar.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String username;

  OTPVerificationScreen({required this.username});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleVerifyOTP() async {
    final otp = _otpController.text;
    final username = widget.username;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/verify/otp'), 
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'otp': otp,
        }),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        // Parse the response body
        final responseBody = jsonDecode(response.body);

        // Extract data from response
        final token = responseBody['token'];
        final role = responseBody['role'];
        final name = responseBody['name'];
        final sessionId = responseBody['session_id'];

        // Store data in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('role', role);
        await prefs.setString('name', name);
        await prefs.setString('session_id', sessionId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful. Welcome $name!')),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to verify OTP. Please try again.')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: CommonAppBar(
        
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
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
