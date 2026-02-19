class BookingSlotResponse {
  final String message;
  final int bookingId;
  final String doctor;
  final String date;
  final String time;

  BookingSlotResponse({
    required this.message,
    required this.bookingId,
    required this.doctor,
    required this.date,
    required this.time,
  });

  // Factory method to create an instance from JSON
  factory BookingSlotResponse.fromJson(Map<String, dynamic> json) {
    return BookingSlotResponse(
      message: json['message'],
      bookingId: json['booking_id'],
      doctor: json['doctor'],
      date: json['date'],
      time: json['time'],
    );
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'booking_id': bookingId,
      'doctor': doctor,
      'date': date,
      'time': time,
    };
  }
}
