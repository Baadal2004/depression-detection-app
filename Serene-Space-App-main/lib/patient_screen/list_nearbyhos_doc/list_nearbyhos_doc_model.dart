class NearbyHosDoctor {
  final int id;
  final String name;
  final String qualification;
  final String specialization;
  final int experience;
  final String? hospitalName;
  final String hospitalAddress;
  final String hospitalPhone;
  final String place;
  final bool available;
  final String status;
  final String image;

  NearbyHosDoctor({
    required this.id,
    required this.name,
    required this.qualification,
    required this.specialization,
    required this.experience,
    required this.hospitalName,
    required this.hospitalAddress,
    required this.hospitalPhone,
    required this.place,
    required this.available,
    required this.status,
    required this.image,
  });

  factory NearbyHosDoctor.fromJson(Map<String, dynamic> json) {
    return NearbyHosDoctor(
      id: json['id'] as int,
      name: json['name'] as String,
      qualification: json['qualification'] as String,
      specialization: json['specialization'] as String,
      experience: json['experience'] as int,
      hospitalName: json['hospital_name'] as String? ?? 'Unknown Clinic',
hospitalAddress: json['hospital_address'] as String,
      hospitalPhone: json['phone'] as String,
      place: json['place'] as String,
      available: json['available'] as bool,
      status: json['status'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'qualification': qualification,
      'specialization': specialization,
      'experience': experience,
      'hospital_name': hospitalName,
      'hospital_address': hospitalAddress,
      'phone': hospitalPhone,
      'place': place,
      'available': available,
      'status': status,
      'image': image,
    };
  }
}
