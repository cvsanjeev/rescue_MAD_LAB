import 'package:flutter/material.dart';

import 'agentLogin.dart';
import 'agencyLogin.dart';
import 'agent_dashboard_screen.dart';
import 'agency_dashboard_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rescue Coordination', // App Title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Basic color theme
      ),
    routes: {
    '/agentLogin': (context) => AgentLoginScreen(),
      '/agencyLogin': (context) => AgencyLoginScreen(),
      '/agentDash': (context) => AgentDashboardScreen(),
      '/agencyDash': (context) => AgencyDashboardScreen(),
    },
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rescue Coordination"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/a.png', // Placeholder - add your logo
              width: 200,              // Adjust the size
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/agentLogin');
              },
              child: Text("Agent Login"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/agencyLogin');
              },
              child: Text("Agency Login"),
            ),
          ],
        ),
      ),
    );
  }
}
