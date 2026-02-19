class UserLoginModel {
  final int userId;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String password;

  UserLoginModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.password,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      userId: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": userId,
      "name": name,
      "email": email,
      "phone": phone,
      "role": role,
      "password": password,
    };
  }
}
