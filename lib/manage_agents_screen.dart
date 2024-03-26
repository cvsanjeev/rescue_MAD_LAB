import 'package:flutter/material.dart';
import 'agent.dart';
import 'agent_dao.dart';
import 'create_agent_screen.dart';
import 'edit_agent_screen.dart';

class ManageAgentsScreen extends StatefulWidget {
  @override
  _ManageAgentsScreenState createState() => _ManageAgentsScreenState();
}

class _ManageAgentsScreenState extends State<ManageAgentsScreen> {
  final _dao = AgentDAO();
  List<Agent> _agents = [];
  final _searchController = TextEditingController();
  int agencyId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Agents"),
        actions: [
          IconButton(onPressed: _loadAgents, icon: Icon(Icons.refresh)), // Refresh
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(hintText: 'Search by Name, Number'),
              onChanged: (text) {
                // Add search logic if you want live filtering
              },
            ),
          ),
          Expanded(
            child: _buildAgentList(),
          ),
        ],
      ),
    floatingActionButton: FloatingActionButton(
    onPressed: _createNewAgent,
    child: Icon(Icons.add),
      // ... (Your FloatingActionButton)
    ));
  }

  @override
  void initState() {
    super.initState();
    _loadAgents();

  }


  // ... (Your _addAgent function)

void _editAgent(Agent agent) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditAgentScreen(agent: agent), // Create EditAgentScreen
    ),
  ).then((value) => _loadAgents()); // Refresh the list after editing
}
  void _createNewAgent() async {
    final newAgent = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateAgentScreen(agencyId: agencyId),
      ),
    );

    if (newAgent != null) {
      setState(() {
        _agents.add(newAgent);
      });
    }
  }

void _deleteAgent(Agent agent) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Confirm Delete'),
      content: Text('Are you sure you want to delete this agent?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Close dialog (Cancel)
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await _dao.deleteAgent(agent);
            _loadAgents(); // Refresh the list
            Navigator.pop(context); // Close dialog (Confirm)
          },
          child: Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

void _changeAgentStatus(Agent agent, String newStatus) async {
  // ... Update the agent and refresh the list ...


// Inside your ListTile:
DropdownButton<String>(
value: agent.status,  // Current status
items: ['Active', 'Offline', 'Other Status'] // List your statuses
.map<DropdownMenuItem<String>>((String value) {
return DropdownMenuItem<String>(
value: value,
child: Text(value),
);
}).toList(),
onChanged: (newStatus) {
if (newStatus != null) {
_changeAgentStatus(agent, newStatus);
}
},
);
}



Widget _buildAgentList() {
    if (_agents == null) {  // Handle initial null state
      return Center(child: CircularProgressIndicator()); // Show loading
    } else if (_agents.isEmpty) {
      return Center(child: Text('No agents found. Add New agents.'));
    } else {
        return ListView.builder(
          itemCount: _agents.length,
          itemBuilder: (context, index) {
            final agent = _agents[index];
            return GestureDetector( // Add the GestureDetector
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Choose an Action"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                            _editAgent(agent);
                          },
                          child: Text("Edit"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _deleteAgent(agent);
                          },
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: ListTile( // Your existing ListTile
                title: Text(agent.name),
                subtitle: Text(agent.mobileNumber),
                trailing: DropdownButton<String>( // Add status dropdown
                  value: agent.status,
                  items: ['Active', 'Offline', 'Other Status']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newStatus) {
                    if (newStatus != null) {
                      setState(() {
                        agent.status = newStatus; // Update agent status locally
                      });
                      _changeAgentStatus(agent, newStatus); // Update in the database
                    }
                  },
                ),
              ),
            );
          },
        );
      }

    }

  Future<void> _loadAgents() async {
    try {
      final agents = await _dao.getAgentsByAgencyId(agencyId);
      setState(() {
        _agents = agents;
      });
    } catch (error) {
      print('Error loading agents: $error');
      // Handle the error (e.g., show a message to the user)
    }
  }

}