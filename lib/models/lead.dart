class Lead {
  int? id;
  String name;
  String contact;
  String notes;
  String status;

  Lead({
    this.id,
    required this.name,
    required this.contact,
    required this.notes,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'notes': notes,
      'status': status,
    };
  }

  factory Lead.fromMap(Map<String, dynamic> map) {
    return Lead(
      id: map['id'],
      name: map['name'],
      contact: map['contact'],
      notes: map['notes'],
      status: map['status'],
    );
  }
}
