import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'emergency_post.dart';
import 'message.dart';

class IssueEmergencyPostScreen extends StatefulWidget {
  @override
  _IssueEmergencyPostScreenState createState() => _IssueEmergencyPostScreenState();
}

class _IssueEmergencyPostScreenState extends State<IssueEmergencyPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _locationController = TextEditingController();
  final _detailsController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
    _locationController.dispose();
    _detailsController.dispose();
    super.dispose();
  }
  GoogleMapController? _mapController;
  LatLng _initialLocation = LatLng(13.36993, 74.78585);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Issue Emergency Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Emergency Type'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an emergency type';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              Expanded(
                child: _buildMap(),
              ),
              TextFormField(
                controller: _detailsController,
                decoration: InputDecoration(labelText: 'Additional Details'),
                maxLines: 3,
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    sendSMS();
                    _submitForm();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      onMapCreated: (controller) => _mapController = controller,
      initialCameraPosition: CameraPosition(
        target: _initialLocation,
        zoom: 15.0,
      ),
      markers: {
        Marker(
          markerId: MarkerId("selected-location"),
          position: _initialLocation,
          draggable: true,
          onDragEnd: (newPosition) {
            setState(() {
              _initialLocation = newPosition; // Update marker
              _locationController.text = '${newPosition.latitude},${newPosition.longitude}';
            });
          },
        ),
      },
    );
  }

  void _submitForm() {
    //final selectedLocation = _mapController!.CameraPosition.target;
    final newPost = EmergencyPost(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Temp ID
      type: _typeController.text,
      location: _locationController.text,
      timestamp: DateTime.now(),
      additionalDetails: _detailsController.text,
      issuingAgentId: 'agent123', // Assuming you have a way to get agent ID
      initialStatus: Status.New,
    );
    Navigator.pop(context, newPost);
  }




}

