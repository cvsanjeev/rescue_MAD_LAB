import 'package:flutter/material.dart';

class AgentProfileScreen extends StatefulWidget {
  @override
  _AgentProfileScreenState createState() => _AgentProfileScreenState();
}

class _AgentProfileScreenState extends State<AgentProfileScreen> {
  // ... variables representing agency data go here ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agent Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            SizedBox(height: 20),
            _buildProfileDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center( // Could include agency logo/name
      child: Column(
        children: [
          Text("Agent Name", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          // Add a placeholder for Agent Logo (CircleAvatar, Image, etc.)
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Contact Information:"),
        // ... Display email, phone number, etc. ...

        Text("Address:"),
        // ... Display address ...

        // ... Add more details as needed ...
      ],
    );
  }
}
