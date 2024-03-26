import 'package:flutter/material.dart';
import 'agent.dart';

class EditAgentScreen extends StatefulWidget {
  final Agent agent;

  const EditAgentScreen({Key? key, required this.agent}) : super(key: key);

  @override
  _EditAgentScreenState createState() => _EditAgentScreenState();
}

class _EditAgentScreenState extends State<EditAgentScreen> {
  // Create controllers for TextFields
  final _nameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  String _selectedStatus = '';

  @override
  void initState() {
    super.initState();
    // Initialize controllers and values with existing agent data
    _nameController.text = widget.agent.name;
    _mobileNumberController.text = widget.agent.mobileNumber;
    _selectedStatus = widget.agent.status;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // 1. Create an updated Agent object
    final updatedAgent = Agent(
      id: widget.agent.id, // Important: Retain the ID
      name: _nameController.text,
      mobileNumber: _mobileNumberController.text,
      status: _selectedStatus,
      agencyId: widget.agent.agencyId,
    );

    // 2. Use your AgentDAO to update in the database
    // ... (Call a function in your AgentDAO like updateAgent(updatedAgent))

    // 3. Navigate back to ManageAgentsScreen and refresh the list
    Navigator.pop(context); // Go back after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Agent"),
        actions: [
          IconButton(
            onPressed: _saveChanges,
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
            // ... Dropdown or other selection mechanism for status

          ],
        ),
      ),
    );
  }
}
