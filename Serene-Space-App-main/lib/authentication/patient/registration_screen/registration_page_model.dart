class PatientRegistrationModel {
  final int id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String place;
  final int age;
  final String? role; // optional since not in response
  final double? latitude; // optional since not in response
  final double? longitude;
  // optional since not in response
  PatientRegistrationModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.place,
    required this.age,
    required this.role,
    required this.latitude,
    required this.longitude,
  });

  factory PatientRegistrationModel.fromJson(Map<String, dynamic> json) {
    return PatientRegistrationModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      place: json['place'] ?? '',
      age: json['age'] ?? 0,
      role: json['user_type'] ?? '', // <-- if API sends later
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "address": address,
      "place":place,
      "age": age,
      "user_type": role,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
