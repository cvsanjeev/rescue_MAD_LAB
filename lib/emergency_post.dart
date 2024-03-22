enum Status { New, Acknowledged, InProgress, Resolved } // Example with enum

class EmergencyPost {
  final String id;
  String additionalDetails;
  final String type;
  final String location;
  DateTime timestamp;
  final String issuingAgentId;
  Status _status;

  EmergencyPost({
    required this.id,
    required this.type,
    required this.location,
    required this.timestamp,
    required this.additionalDetails,
    required this.issuingAgentId,
    required Status initialStatus,
  }) : _status = initialStatus;

  String get status => _status.name; // Convert enum to string for display

  void updateStatus(Status newStatus) {
    _status = newStatus;
  }

  // Methods for database interaction:
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'location': location,
      'timestamp': timestamp.toString(),
      'status': status, // Convert enum to string
      'additional_details': additionalDetails,
      'issuing_agent_id': issuingAgentId,
    };
  }

  static EmergencyPost fromMap(Map<String, dynamic> map) {
    return EmergencyPost(
      id: map['id'],
      type: map['type'],
      location: map['location'],
      timestamp: DateTime.parse(map['timestamp']),
      initialStatus: Status.values.byName(map['status']),
      additionalDetails: map['additional_details'],
      issuingAgentId: map['issuing_agent_id'],
    );
  }
}
