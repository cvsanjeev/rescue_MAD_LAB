import 'package:flutter/material.dart';
import 'emergency_post.dart';

class IssueEmergencyPostScreen extends StatefulWidget {
  @override
  _IssueEmergencyPostScreenState createState() => _IssueEmergencyPostScreenState();
}

class _IssueEmergencyPostScreenState extends State<IssueEmergencyPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _locationController = TextEditingController();
  final _detailsController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
    _locationController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Issue Emergency Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Emergency Type'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an emergency type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _detailsController,
                decoration: InputDecoration(labelText: 'Additional Details'),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitForm();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    final newPost = EmergencyPost(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Temp ID
      type: _typeController.text,
      location: _locationController.text,
      timestamp: DateTime.now(),
      additionalDetails: _detailsController.text,
      issuingAgentId: 'agent123', // Assuming you have a way to get agent ID
      initialStatus: Status.New,
    );
    Navigator.pop(context, newPost);
  }
}
