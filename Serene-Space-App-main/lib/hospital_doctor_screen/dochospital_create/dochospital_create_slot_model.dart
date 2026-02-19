class HospitalDoctorSlotModel {
  final int id;
  final int doctor;
  final String doctorName;
  final String date;
  final String startTime;
  final String endTime;
  final List<String> timeslots;

  HospitalDoctorSlotModel({
    required this.id,
    required this.doctor,
    required this.doctorName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.timeslots,
  });

  factory HospitalDoctorSlotModel.fromJson(Map<String, dynamic> json) {
    return HospitalDoctorSlotModel(
      id: json['id'] as int,
      doctor: json['doctor'] as int,
      doctorName: json['doctor_name'] as String,
      date: json['date'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      timeslots: (json['timeslots'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'doctor': doctor,
    'doctor_name': doctorName,
    'date': date,
    'start_time': startTime,
    'end_time': endTime,
    'timeslots': timeslots,
  };
}
