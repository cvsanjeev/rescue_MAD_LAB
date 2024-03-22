import 'package:flutter/material.dart';
import 'emergency_post.dart';

class AgencyDashboardScreen extends StatefulWidget {
  @override
  _AgencyDashboardScreenState createState() => _AgencyDashboardScreenState();
}

class _AgencyDashboardScreenState extends State<AgencyDashboardScreen> {
  final List<EmergencyPost> _emergencyPosts = [
    EmergencyPost(
        id: '1',
        type: "Fire",
        location: "Sector 12",
        timestamp: DateTime.now(),
        additionalDetails: 'Building fire',
        issuingAgentId: 'agent123',
        initialStatus: Status.New), // Use the enum
    EmergencyPost(
        id: '2',
        type: "Medical",
        location: "Main Market",
        additionalDetails: 'Building fire',
        issuingAgentId: 'agent123',
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
        initialStatus: Status.Acknowledged), // Use the enum
  ];
  void _handleLogout() {
    Navigator.pushReplacementNamed(context, '/agencyLogin');}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agency Dashboard"),
        actions: [IconButton(onPressed: _handleLogout , icon: Icon(Icons.logout))],
      ),
      body: Column(
        children: [
          _buildNotificationArea(),
          Expanded(
            child: _buildEmergencyPostList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationArea() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.red[100], // Placeholder color
      child: Row(
        children: [
          Icon(Icons.notifications_active),
          SizedBox(width: 10),
          Text("New Emergency: Fire at Sector 5"), // Dynamic from data
        ],
      ),
    );
  }

  Widget _buildEmergencyPostList() {
    return ListView.builder(
      itemCount: _emergencyPosts.length,
      itemBuilder: (context, index) {
        return _buildPostCard(_emergencyPosts[index]);
      },
    );
  }

  Widget _buildPostCard(EmergencyPost post) {
    return Card(
      child: ListTile(
        title: Text(post.type),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.location),
            Text(post.status),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Update status (in real app, send to backend)
            setState(() {
              post.updateStatus(Status.Acknowledged);
            });
          },
          child: Text("Acknowledge"),
        ),
      ),
    );
  }
}
