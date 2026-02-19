class Doctor {
  final int id;
  final String name;
  final String qualification;
  final String hospitalName;
  final String hospitalAddress;
  final String hospitalPhone;
  final String email;
  final String phno;
  final String doctorImage;
  final double distanceKm;

  Doctor({
    required this.id,
    required this.name,
    required this.qualification,
    required this.hospitalName,
    required this.hospitalAddress,
    required this.hospitalPhone,
    required this.email,
    required this.phno,
    required this.doctorImage,
    required this.distanceKm,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      qualification: json['qualification'] ?? '',
      hospitalName: json['hospital_name'] ?? '',
      hospitalAddress: json['hospital_address'] ?? '',
      hospitalPhone: json['hospital_phone'] ?? '',
      email: json['email'] ?? '',
      phno: json['phno'] ?? '',
      doctorImage: json['doctor_image'] ?? '',
      distanceKm: (json['distance_km'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'qualification': qualification,
      'hospital_name': hospitalName,
      'hospital_address': hospitalAddress,
      'hospital_phone': hospitalPhone,
      'email': email,
      'phno': phno,
      'doctor_image': doctorImage,
      'distance_km': distanceKm,
    };
  }
}

class NearestDoctorsResponse {
  final List<Doctor> nearestDoctors;

  NearestDoctorsResponse({required this.nearestDoctors});

  factory NearestDoctorsResponse.fromJson(Map<String, dynamic> json) {
    var docs = (json['nearest_doctors'] as List?) ?? [];
    return NearestDoctorsResponse(
      nearestDoctors: docs.map((d) => Doctor.fromJson(d)).toList(),
    );
  }
}
