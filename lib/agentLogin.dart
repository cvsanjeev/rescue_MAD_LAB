import 'package:flutter/material.dart';

class AgentLoginScreen extends StatefulWidget {
  @override
  _AgentLoginScreenState createState() => _AgentLoginScreenState();
}

class _AgentLoginScreenState extends State<AgentLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileNumberController = TextEditingController();
  final _otpController = TextEditingController(); // For the OTP input field
  bool _showOtpField = false;

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _requestOtp() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _showOtpField = true;
      });
    }
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Hardcoded OTP Logic (Temporary)
      if (_otpController.text == "123456") {
        Navigator.pushReplacementNamed(context, '/agentDash');
      } else {
        // Display error message (e.g., SnackBar or Dialog)
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Invalid OTP"))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agent Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _mobileNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Mobile Number"),
                validator: (value) {

                    if (value!.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if(value!.length<10)
                      return 'Please enter valid mobile number';
                    // Add more robust phone number validation if needed

                  return null;
                },
              ),
              SizedBox(height: 20),
              if (_showOtpField)
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Enter OTP"),
                  validator: (value) {
                    // Add basic OTP validation here
                    return null;
                  },
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showOtpField ?  _handleLogin : _requestOtp,
                child: Text(_showOtpField ?  "Verify & Login" : "Request OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}