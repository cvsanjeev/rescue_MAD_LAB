import 'package:flutter/material.dart';
import 'emergency_post.dart';
import 'emergency_post_dao.dart';

class AgencyDashboardScreen extends StatefulWidget {
  @override
  _AgencyDashboardScreenState createState() => _AgencyDashboardScreenState();
}

class _AgencyDashboardScreenState extends State<AgencyDashboardScreen> {
  final _dao = EmergencyPostDAO(); // Create DAO instance
  List<EmergencyPost> _emergencyPosts = [];

  @override
  void initState() {
  super.initState();
  _loadPosts();
  }

  Future<void> _loadPosts() async {
  final posts = await _dao.getAllPosts();
  setState(() {
  _emergencyPosts = posts;
  });
  }
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
    return FutureBuilder<EmergencyPost?>(
      future: _fetchLatestEmergency(),  // Fetch data on widget build
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error loading notification'));
        } else if (snapshot.hasData && snapshot.data != null) {
          EmergencyPost latestPost = snapshot.data!;
          return Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.red[100],
            child: Row(
              children: [
                Icon(Icons.notifications_active),
                SizedBox(width: 10),
                Flexible( // Introduce flexibility to handle long text
                  child: Text("New Emergency: ${latestPost.type} at ${latestPost.location}"),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  Future<EmergencyPost?> _fetchLatestEmergency() async {
    final posts = await _dao.getAllPosts();
    if (posts.isNotEmpty) {
      // Assuming your posts are sorted with the newest first
      return posts.last;
    } else {
      return null;
    }
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
          onPressed: () async {

            setState(() {
              post.updateStatus(Status.Acknowledged);
            });
            await _dao.updateStatus(post, Status.Acknowledged);
            setState(() {});
          },
          child: Text("Acknowledge"),
        ),
      ),
    );
  }
}
