import 'package:flutter/material.dart';
import 'emergency_post.dart';
import 'emergency_post_dao.dart';
import 'issue_emergency_post_screen.dart';

class AgentDashboardScreen extends StatefulWidget {
  @override
  _AgentDashboardScreenState createState() => _AgentDashboardScreenState();
}

class _AgentDashboardScreenState extends State<AgentDashboardScreen> {
  final String agencyName = "Agency X";
  final _dao = EmergencyPostDAO(); // Create DAO instance
  List<EmergencyPost> _emergencyPosts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final posts = await _dao.getAllPosts(); // Fetch from database
    setState(() {
      _emergencyPosts = posts;
    });
  }
  void _handleLogout() {
    Navigator.pushReplacementNamed(context, '/agentLogin');}

  void _handleMenuSelection(String choice) {
    switch (choice) {
      case 'profile':
        Navigator.pushNamed(context, '/agentProfile');
        break;
      case 'logout':
        _handleLogout();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agent Dashboard - $agencyName"),
      actions: [
        PopupMenuButton<String>( // Add a PopupMenuButton
          onSelected: _handleMenuSelection,
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(value: 'profile', child: Text('Profile')),
              PopupMenuItem(value: 'logout', child: Text('Logout')),
            ];
          },
        ),
      ],),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                // 1. Navigate to the Issue Emergency Post screen
                final newPost = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => IssueEmergencyPostScreen())
                );

                // 2. Handle the new post
                if (newPost != null) {
                  _dao.insertPost(newPost); // Insert into database
                  setState(() {
                    _emergencyPosts.add(newPost); // Update the UI
                  });
                }
              },
              child: Text("Issue Emergency Post"),
            ),

          ),
          Expanded(
            child: _buildEmergencyPostList(), // Call the function here
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyPostList() {
    if (_emergencyPosts.isEmpty) {
      return Center(child: Text('No Previous Posts'));
    } else {
      return ListView.builder(
        itemCount: _emergencyPosts.length,
        itemBuilder: (context, index) {
          return _buildPostCard(_emergencyPosts[index]);
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
