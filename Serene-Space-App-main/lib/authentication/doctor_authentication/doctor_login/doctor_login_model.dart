class DoctorLoginModel {
  final int id;
  final String name;
  final String email;
  final String doctorId;
  final String role;
  final String status;

  DoctorLoginModel({
    required this.id,
    required this.name,
    required this.email,
    required this.doctorId,
    required this.role,
    required this.status,
  });

  factory DoctorLoginModel.fromJson(Map<String, dynamic> json) {
    return DoctorLoginModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      doctorId: json['password'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": doctorId,
      "role": role,
      "status": status,
    };
  }
}
