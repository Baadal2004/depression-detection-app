class Timeslot {
  final String time;
  final bool isBooked;

  Timeslot({required this.time, required this.isBooked});

  factory Timeslot.fromJson(Map<String, dynamic> json) {
    return Timeslot(
      time: json['time'] as String,
      isBooked: json['is_booked'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'time': time, 'is_booked': isBooked};
  }
}

class HospitalDoctorSlotResponse {
  final int id;
  final int doctor;
  final String doctorName;
  final String date;
  final String startTime;
  final String endTime;
  final List<Timeslot> timeslots;

  HospitalDoctorSlotResponse({
    required this.id,
    required this.doctor,
    required this.doctorName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.timeslots,
  });

  factory HospitalDoctorSlotResponse.fromJson(Map<String, dynamic> json) {
    var list = json['timeslots'] as List<dynamic>;
    List<Timeslot> slotList = list.map((i) => Timeslot.fromJson(i)).toList();

    return HospitalDoctorSlotResponse(
      id: json['id'] as int,
      doctor: json['doctor'] as int,
      doctorName: json['doctor_name'] as String,
      date: json['date'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      timeslots: slotList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor': doctor,
      'doctor_name': doctorName,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'timeslots': timeslots.map((e) => e.toJson()).toList(),
    };
  }
}
