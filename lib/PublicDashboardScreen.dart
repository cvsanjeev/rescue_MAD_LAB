import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'emergency_post.dart';
import 'emergency_post_dao.dart';

class PublicDashboardScreen extends StatefulWidget {
  @override
  _PublicDashboardScreenState createState() => _PublicDashboardScreenState();
}

class _PublicDashboardScreenState extends State<PublicDashboardScreen> {
  final _dao = EmergencyPostDAO();
  List<EmergencyPost> _emergencyPosts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final posts = await _dao.getAllPosts(); // Or filtered posts
    setState(() {
      _emergencyPosts = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Public Dashboard"),
      ),
      body: _emergencyPosts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : _buildEmergencyPostList(),
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
        child: GestureDetector( // Add GestureDetector here
          onTap: () {
            // Handle the tap event - Navigate to details
            Navigator.pushNamed(context, '/emergencyDetails', arguments: {'emergencyPost': post});
          },
          child: ListTile(
            title: Text(post.type),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.location),
                Text(post.status),
              ],
            ),
            trailing: Row( // Wrap buttons in a Row for better layout
              mainAxisSize: MainAxisSize.min, // Keep buttons close together

            ),
          ),
        ));
  }
// ... (Reuse your _buildEmergencyPostList with modifications if needed)
}
