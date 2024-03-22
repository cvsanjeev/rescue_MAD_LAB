import 'package:flutter/material.dart';
import 'emergency_post.dart';

class AgentDashboardScreen extends StatefulWidget {
  @override
  _AgentDashboardScreenState createState() => _AgentDashboardScreenState();
}

class _AgentDashboardScreenState extends State<AgentDashboardScreen> {
  final String agencyName = "Agency X";
   List<EmergencyPost> emergencyPosts = [];

  @override
  void initState() {
    super.initState();
    _fetchMockPosts(); // Fetch mock data on initialization
  }

  void _fetchMockPosts() {
    setState(() {
      emergencyPosts = [
        EmergencyPost(
          id: '1',
          type: 'Fire',
          location: 'Sector 5',
          initialStatus: Status.New, // Use the enum for initial status
          timestamp: DateTime.now(),
          additionalDetails: 'Building fire',
          issuingAgentId: 'agent123',
        ),
        // ... add more mock posts with different statuses if desired
      ];
    });
  }
  void _handleLogout() {
    Navigator.pushReplacementNamed(context, '/agentLogin');}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agent Dashboard - $agencyName"),
        actions: [IconButton(onPressed:  _handleLogout , icon: Icon(Icons.logout))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Replace with actual navigation logic later
                print("Navigate to Issue Emergency Post screen");
              },
              child: Text("Issue Emergency Post"),
            ),
          ),
          Expanded(
            child: _buildEmergencyPostList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyPostList() {
    if (emergencyPosts.isEmpty) {
      return Center(child: Text('No Previous Posts'));
    } else {
      return ListView.builder(
        itemCount: emergencyPosts.length,
        itemBuilder: (context, index) {
          return _buildPostCard(emergencyPosts[index]);
        },
      );
    }
  }

  Widget _buildPostCard(EmergencyPost post) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.type, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Location: ${post.location}'),
            Text('Status: ${post.status}'),
            Text('Submitted: ${post.timestamp}'),
            SizedBox(height: 8),
            Text('Details: ${post.additionalDetails}'),
          ],
        ),
      ),
    );
  }
}
