class Agent {
  final int? id;
  final String name;
  final String mobileNumber;
  String status;
  final int agencyId;

  Agent({
     this.id, // Add a unique identifier
    required this.name,
    required this.mobileNumber,
    required this.status,
    required this.agencyId,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobileNumber': mobileNumber,
      'status': status,
      'agencyId': agencyId, // Include the agencyId
    };
  }
}
