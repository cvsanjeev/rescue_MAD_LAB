import 'package:flutter/material.dart';
import 'agent_dao.dart';
class AgentLoginScreen extends StatefulWidget {
  @override
  _AgentLoginScreenState createState() => _AgentLoginScreenState();
}

class _AgentLoginScreenState extends State<AgentLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileNumberController = TextEditingController();
  final _otpController = TextEditingController(); // For the OTP input field
  bool _showOtpField = false;
  final _agentDAO = AgentDAO();
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

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final enteredAgentId = int.tryParse(_mobileNumberController.text) ?? -1;

      if (enteredAgentId == -1) {
        // Handle invalid ID (Display error message)
      } else {
        try {
          // Fetch agent data
          final agent = await _agentDAO.getAgentById(enteredAgentId);

          if (agent != null) {
            if (agent.isNotEmpty) {
              int? firstAgentId = agent[0].id;
             // print(firstAgentId);
            }

            // Compare OTP with agent's stored OTP (if you store OTPs)
            if (_otpController.text == "123456") { // Replace with your OTP logic
              Navigator.pushReplacementNamed(context, '/agentDash', arguments: {'agentId': agent[0].id}); // Pass agentId
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Invalid OTP"))
              );
            }
          } else {
            // Handle the case where the agent was not found
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Agent not found"))
            );
          }
        } catch (error) {
          print('Error Logging In: $error');
          // Handle general errors during the login process
        }
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