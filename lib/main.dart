import 'package:flutter/material.dart';
import 'package:untitled1/PublicDashboardScreen.dart';
import 'package:untitled1/MapBody.dart';

import 'EmergencyDetailsScreen.dart';
import 'agent.dart';
import 'agentLogin.dart';
import 'agencyLogin.dart';
import 'agent_dao.dart';
import 'agent_dashboard_screen.dart';
import 'agency_dashboard_screen.dart';
import 'agency_profile_screen.dart';
import 'agent_profile_screen.dart';
import 'manage_agents_screen.dart';
import 'agency_dao.dart';
import 'agency.dart';
import 'PublicDashboardScreen.dart';


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
      '/agencyProfile': (context) => AgencyProfileScreen(),
      '/agentProfile': (context) => AgentProfileScreen(),
      '/manageAgents': (context)=> ManageAgentsScreen(),
      '/emergencyDetails': (context) => EmergencyDetailsScreen(),
      '/dashboard': (context) => PublicDashboardScreen(),
      '/map': (context) => MapBody(),
    },
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  final _agencyDAO = AgencyDAO();
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

            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/dashboard'); // Replace '/dashboard' with your actual route name
              },
              child: Text('Public Dashboard'), // Changed to 'Dashboard'
            ),
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
/*
             ElevatedButton(
              onPressed: () async {
                final agency1 = agency(name: 'Manipal Police Station', id: 1, address: '');
                //final agent1 = Agent(name: 'Agent Name',mobileNumber: '8138888678', status: 'Active',agencyId: 1, );
                final newAgencyId = await _agencyDAO.insertAgency(agency1);
                //final dao = AgentDAO();
                //final newAgent=await dao.insertAgent(agent1);
              },
              child: Text('Admin'),
            ),
*/
          ],
        ),
      ),
    );
  }
}
