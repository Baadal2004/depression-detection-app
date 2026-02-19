class HospitalRegModel {
  final int id;
  final String hospitalname;
  final String name;
  final String email;
  final String password;
  final String qualification;
  final String specialization;
  final int experience;
  final String hospitalAddress;
  final String hospitalPhone;
  final double latitude;
  final double longitude;
  final String role;
  final int age;
  final String gender;
  final String place;
  final String image;
  final String medicalId;
  final bool available;
  final String status;

  HospitalRegModel({
    required this.id,
    required this.hospitalname,
    required this.name,
    required this.email,
    required this.password,
    required this.qualification,
    required this.specialization,
    required this.experience,
    required this.hospitalAddress,
    required this.hospitalPhone,
    required this.latitude,
    required this.longitude,
    required this.role,
    required this.age,
    required this.gender,
    required this.place,
    required this.image,
    required this.medicalId,
    required this.available,
    required this.status,
  });

  factory HospitalRegModel.fromJson(Map<String, dynamic> json) {
    return HospitalRegModel(
      id: json['id'] as int,
      hospitalname:json['hospital_name'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      qualification: json['qualification'] as String,
      specialization: json['specialization'] as String,
      experience: json['experience'] as int,
      hospitalAddress: json['hospital_address'] as String,
      hospitalPhone: json['hospital_phone'] as String,
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      role: json['role'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      place: json['place'] as String,
      image: json['image'] as String,
      medicalId: json['medical_id'] as String,
      available: json['available'] as bool,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'hospital_name':hospitalname,
    'name': name,
    'email': email,
    'password': password,
    'qualification': qualification,
    'specialization': specialization,
    'experience': experience,
    'hospital_address': hospitalAddress,
    'hospital_phone': hospitalPhone,
    'latitude': latitude,
    'longitude': longitude,
    'role': role,
    'age': age,
    'gender': gender,
    'place': place,
    'image': image,
    'medical_id': medicalId,
    'available': available,
    'status': status,
  };
}
