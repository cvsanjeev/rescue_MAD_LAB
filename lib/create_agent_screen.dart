import 'package:flutter/material.dart';
import 'agent.dart';
import 'agent_dao.dart';

class CreateAgentScreen extends StatefulWidget {
  final int agencyId;

  const CreateAgentScreen({Key? key, required this.agencyId}) : super(key: key);

  @override
  _CreateAgentScreenState createState() => _CreateAgentScreenState();
}

class _CreateAgentScreenState extends State<CreateAgentScreen> {
  final _dao = AgentDAO(); // Initialize your DAO
  final _nameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  String _selectedStatus = 'Active'; // Set a default status

  @override
  void dispose() {
    _nameController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  void _saveAgent() async {
    final newAgent = Agent(
      name: _nameController.text,
      mobileNumber: _mobileNumberController.text,
      status: _selectedStatus,
      agencyId: widget.agencyId,
    );

    // TODO: Add Validation for entered data if required

    try {
      await _dao.insertAgent(newAgent);
      Navigator.pop(context, newAgent); // Return the created agent
    } catch (error) {
      print('Error saving agent: $error');
      // Implement error handling (show a dialog or snackbar to the user)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Agent"),
        actions: [
          IconButton(
            onPressed: _saveAgent,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _mobileNumberController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
            ),
            DropdownButton<String>(
              value: _selectedStatus,
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
                    _selectedStatus = newStatus;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
