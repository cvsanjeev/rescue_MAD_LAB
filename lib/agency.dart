class agency {
  final int id;
  final String name;
  final String address;
  // ... other details

  agency({required this.id, required this.name, required this.address});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address':address,
    };
  }
}
