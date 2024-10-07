// lead_model.dart
class Lead {
  final String id;
  final String name;
  final String location;
  final String email;
  final String phone;
  final String? status;

  Lead({
    required this.id,
    required this.name,
    required this.location,
    required this.email,
    required this.phone,
    this.status,
  });

  // Method to update status
  Lead updateStatus(String newStatus) {
    return Lead(
      id: id,
      name: name,
      location: location,
      email: email,
      phone: phone,
      status: newStatus,
    );
  }
}
