import 'package:flutter/material.dart';

class AgencyLoginScreen extends StatefulWidget {
  @override
  _AgencyLoginScreenState createState() => _AgencyLoginScreenState();
}

class _AgencyLoginScreenState extends State<AgencyLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passkeyController = TextEditingController();

  @override
  void dispose() {
    _passkeyController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // In a real app:
      // 1. Retrieve the passkey from the controller
      // 2. Send a login request to your backend
      // 3. Validate the passkey against your database
      // For now, let's simulate successful login:
      Navigator.pushReplacementNamed(context, '/agencyDash');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agency Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _passkeyController,
                obscureText: true,  // Hide the passkey
                decoration: InputDecoration(labelText: "Passkey"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your passkey';
                  }
                  // Add more specific passkey validation logic here
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleLogin,
                child: Text("Verify & Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
