import 'package:flutter/material.dart';

class ManageAgentsScreen extends StatefulWidget {
  @override
  _ManageAgentsScreenState createState() => _ManageAgentsScreenState();
}

class _ManageAgentsScreenState extends State<ManageAgentsScreen> {
  List<Agent> _agents = []; // Sample agent list

  @override
  void initState() {
    super.initState();
    _agents = [ // Placeholder data, will be replaced with database data
      Agent(name: 'Agent One', status: 'Active'),
      Agent(name: 'Agent Two', status: 'Offline'),
    ];
  }

  void _addAgent() {
    // ... Show a dialog or navigate to a separate screen to add an agent ...
  }

  void _editAgent(Agent agent) {
    // ... Show a dialog or navigate to a screen to edit the selected agent ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Agents"),
      ),
      body: _buildAgentList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAgent,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildAgentList() {
    return ListView.builder(
      itemCount: _agents.length,
      itemBuilder: (context, index) {
        final agent = _agents[index];
        return ListTile(
          title: Text(agent.name),
          subtitle: Text('Status: ${agent.status}'),
          onTap: () => _editAgent(agent),
        );
      },
    );
  }
}

// Simple Agent data model
class Agent {
  final String name;
  final String status;

  Agent({required this.name, required this.status});
}
