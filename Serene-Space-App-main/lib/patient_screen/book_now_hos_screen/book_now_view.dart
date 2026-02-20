import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:serene_space_project/constant_uri.dart';
import 'package:serene_space_project/patient_screen/book_now_hos_screen/bloc/book_now_bloc.dart';
import 'package:serene_space_project/patient_screen/feeback_hospage.dart';
import 'package:serene_space_project/patient_screen/view_my_hosbooking.dart';

class BookNowHosScreen extends StatefulWidget {
  const BookNowHosScreen({
    super.key,
    required this.doctorId,
    required this.userId,
  });
  final int doctorId;
  final int userId;

  @override
  State<BookNowHosScreen> createState() => _BookNowHosScreenState();
}

class _BookNowHosScreenState extends State<BookNowHosScreen> {
  int selectedSlotIndex = -1;
  int selectedDateIndex = 0;
  int? userId;
  int? doctorId;
  List<dynamic> timeSlotGroups = [];
  int? selectedGroupIndex;
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    doctorId = widget.doctorId;
    // Call the API to fetch timeslots when page loads
    context.read<BookHosBloc>().add(
      BookHosEvent.bookNow(doctorId: widget.doctorId),
    );
    fetchDoctorTimeSlots();
  }

  String formatDate(String dateStr) {
    final date = DateTime.parse(dateStr); // "2025-11-01"
    return DateFormat('dd-MM-yyyy').format(date);
  }

  Future<void> fetchDoctorTimeSlots() async {
    try {
      // Use your service here or API call
      final url = Uri.parse(
        '${baseUrl}userapp/hospital/doctor/${widget.doctorId}/timeslots/',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          timeSlotGroups = data;
        });
      } else {
        debugPrint(' Failed to load time slots: ${response.body}');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load time slots')),
        );
      }
    } catch (e) {
      debugPrint(' Exception fetching time slots: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load time slots')),
      );
    }
  }

  void _showBookingSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Booking Done!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "Your appointment request has been sent to the doctor. You can track the approval status in 'My Appointments'.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return HosDoctorAppointmentsPages(userId: userId!);
                  },
                ),
              );
            },
            child: const Text("View My Appointments"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return HosFeedbackPage(userid: userId, doctorId: doctorId);
                  },
                ),
              );
            },
            child: const Text("Give Feedback"),
          ),
        ],
      ),
    );
  }

  Future<void> bookSlot() async {
    if (selectedGroupIndex == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a time slot')),
      );
      return;
    }

    final selectedGroup = timeSlotGroups[selectedGroupIndex!];

    final bookingData = {
      'doctor': widget.doctorId,
      'user': widget.userId,
      'timeslot_group': selectedGroup['id'],
      'date': selectedGroup['date'],
      'time': selectedTime,
    };

    final url = Uri.parse(Urlsss.hospitalBookSlot);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bookingData),
    );

    final responseBody = json.decode(response.body);

    if (response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      _showBookingSuccessDialog();
      debugPrint('Booking Response: $responseBody');
    } else {
      debugPrint(' Booking failed: ${response.body}');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking failed: ${responseBody['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF18214A)),
        title: const Text(
          'Book an Appointment',
          style: TextStyle(
            color: Color(0xFF18214A),
            fontWeight: FontWeight.w600,
            fontSize: 21,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<BookHosBloc, BookHosState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error) => Center(child: Text(error)),
            success: (response) {
              if (response.isEmpty) {
                return const Center(child: Text('No slots available'));
              }
              final doctorSlot = response[selectedDateIndex];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        formatDate(doctorSlot.date),
                        style: const TextStyle(
                          color: Color(0xFF18214A),
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "Available Slots",
                      style: TextStyle(
                        color: Color(0xFF18214A),
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: doctorSlot.timeslots.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.25,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                      itemBuilder: (context, i) {
                        final timeslot = doctorSlot.timeslots[i];
                        final isAvailable = !timeslot.isBooked;
                        final isSelected =
                            selectedSlotIndex == i &&
                            selectedGroupIndex == selectedDateIndex;
                        return GestureDetector(
                          onTap: isAvailable
                              ? () {
                                  setState(() {
                                    selectedSlotIndex = i;
                                    selectedGroupIndex = selectedDateIndex;
                                    selectedTime = timeslot.time;
                                  });
                                }
                              : null,
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFF1F6FF)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF2788F9)
                                    : Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                timeslot.time,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: !isAvailable
                                      ? Colors.grey
                                      : (isSelected
                                          ? const Color(0xFF2788F9)
                                          : const Color(0xFF18214A)),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed:
                            selectedGroupIndex != null && selectedTime != null
                            ? bookSlot
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              selectedGroupIndex != null && selectedTime != null
                              ? const Color(0xFF2788F9)
                              : Colors.grey[400],
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 100,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
