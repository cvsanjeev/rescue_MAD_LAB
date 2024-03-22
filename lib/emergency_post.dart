

enum Status { New, Acknowledged, InProgress, Resolved } // Example with enum

class EmergencyPost {
  final String id;
  String additionalDetails;
  final String issuingAgentId;
   final String type;
   final String location;
   DateTime timestamp;
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
}
