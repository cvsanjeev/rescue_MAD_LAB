import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'emergency_post.dart';

class EmergencyDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final EmergencyPost post = args['emergencyPost'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Type: ${post.type}", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Location: ${post.location}"),
            SizedBox(height: 10),
            Text("Status: ${post.status}"),
            //SizedBox(height: 10),
            //Text("Issued By: ${post.issuingAgentId}"),
            // ... Add more fields as needed
          ],
        ),
      ),
    );
  }
}

