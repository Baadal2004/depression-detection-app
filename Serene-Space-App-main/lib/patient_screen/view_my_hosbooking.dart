import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:serene_space_project/patient_screen/home_screen.dart';
import 'package:serene_space_project/constant_uri.dart';

class HosDoctorAppointmentsPages extends StatefulWidget {
  final int userId;
  const HosDoctorAppointmentsPages({super.key, required this.userId});

  @override
  State<HosDoctorAppointmentsPages> createState() =>
      _HosDoctorAppointmentsPagesState();
}

class _HosDoctorAppointmentsPagesState extends State<HosDoctorAppointmentsPages> {
  List<dynamic> bookings = [];
  bool isLoading = true;
  String? errorText;
  int? userId;

  @override
  void initState() {
    super.initState();
    fetchBookings();
   // fetchClinBookings();
    userId = widget.userId;
  }

  String formatDate(String dateStr) {
    final date = DateTime.parse(dateStr); // "2025-11-01"
    return DateFormat('dd-MM-yyyy').format(date);
  }

Future<void> fetchBookings() async {
  setState(() {
    isLoading = true;
    errorText = null;
  });
  final url = Uri.parse(
    '${baseUrl}userapp/user/${widget.userId}/hospital/bookings/',
  );
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final hospitalBookings = jsonDecode(response.body) as List<dynamic>;
      setState(() {
        bookings.addAll(hospitalBookings);  // Append hospital bookings
        isLoading = false;
      });
    } else {
      setState(() {
        errorText = 'Failed to load hospital bookings';
        isLoading = false;
      });
    }
  } catch (e) {
    setState(() {
      errorText = 'Error: $e';
      isLoading = false;
    });
  }
}

Future<void> fetchClinBookings() async {
  setState(() {
    isLoading = true;
    errorText = null;
  });
  final url = Uri.parse(
    '${baseUrl}userapp/user/${widget.userId}/clinic/bookings/',
  );
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final clinicBookings = jsonDecode(response.body) as List<dynamic>;
      setState(() {
        bookings.addAll(clinicBookings);  // Append clinic bookings
        // Optionally sort here by date & time descending or ascending
        bookings.sort((a, b) {
          final dateA = DateTime.parse(a['date']);
          final dateB = DateTime.parse(b['date']);
          // To sort earliest first, use dateA.compareTo(dateB)
          // To sort latest first, use dateB.compareTo(dateA)
          return dateA.compareTo(dateB);
        });
        isLoading = false;
      });
    } else {
      setState(() {
        errorText = 'Failed to load clinic bookings';
        isLoading = false;
      });
    }
  } catch (e) {
    setState(() {
      errorText = 'Error: $e';
      isLoading = false;
    });
  }
}


  // String formatDate(String date) {
  //   // Expects "2025-11-01" and returns "November 01, 2025"
  //   try {
  //     final d = DateTime.parse(date);
  //     return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  //   } catch (_) {
  //     return date;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      appBar: AppBar(
        title: const Text('My Appointments'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen(userId: userId!);
                  },
                ),
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorText != null
          ? Center(child: Text(errorText!))
          : Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0,
              ),
              child: ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final appoint = bookings[index];
                  return Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SL no & patient name
                          Row(
                            children: [
                              Text(
                                "${(index + 1).toString().padLeft(2, '0')}. ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  appoint['doctor_name'] ?? 'Unknown',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Date and Time row
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 18,
                                color: Color(0xFF06857B),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                formatDate(appoint['date']),
                                style: const TextStyle(
                                  color: Color(0xFF424B5A),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 18),
                              const Icon(
                                Icons.access_time_filled,
                                size: 18,
                                color: Color(0xFF06857B),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                appoint['time'] ?? '',
                                style: const TextStyle(
                                  color: Color(0xFF424B5A),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          // If you want to show doctor name:
                          // const SizedBox(height: 4),
                          // Text("Doctor: ${appoint['doctor_name']}")
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
