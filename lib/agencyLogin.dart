import 'package:flutter/material.dart';
import 'agency_dao.dart';

class AgencyLoginScreen extends StatefulWidget {
  @override
  _AgencyLoginScreenState createState() => _AgencyLoginScreenState();
}

class _AgencyLoginScreenState extends State<AgencyLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passkeyController = TextEditingController();
  final _agencyDAO = AgencyDAO();

  @override
  void dispose() {
    _passkeyController.dispose();
    super.dispose();
  }

  void _handleLogin() async { // Make it asynchronous
    if (_formKey.currentState!.validate()) {
      final enteredAgencyId = int.tryParse(_passkeyController.text) ?? -1; // Get Agency ID

      if (enteredAgencyId == -1) {
        //  Handle invalid ID
      } else {
        // Fetch from database (using AgencyDAO)
        final agency = await _agencyDAO.getAgencyById(enteredAgencyId);

        if (agency != null) {
          // Successful login, navigate...
          Navigator.pushReplacementNamed(
              context,
              '/agencyDash',
              arguments: {'agencyId': agency.id} // Pass the ID
          );

        } else {
          // Show "Invalid ID" error message
        }
      }
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
