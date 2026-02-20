import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:serene_space_project/hospital_doctor_screen/hospital_home_screen/hospital_home_screen.dart';
import 'package:serene_space_project/constant_uri.dart';

class HosDoctorAppointmentsPage extends StatefulWidget {
  final int doctorId;
  const HosDoctorAppointmentsPage({super.key, required this.doctorId});

  @override
  State<HosDoctorAppointmentsPage> createState() =>
      _HosDoctorAppointmentsPageState();
}

class _HosDoctorAppointmentsPageState extends State<HosDoctorAppointmentsPage> {
  List<dynamic> bookings = [];
  bool isLoading = true;
  String? errorText;
  int? doctorId;

  @override
  void initState() {
    super.initState();
    fetchBookings();
    doctorId = widget.doctorId;
   // print('doctorId=====$doctorId');
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
    '${baseUrl}userapp/hospital/doctor/${widget.doctorId}/bookings/',
  );
 // print('Fetching bookings from: $url'); // Debug log
  try {
    final response = await http.get(url);
 //   print('Response code: ${response.statusCode}'); // Debug log
    if (response.statusCode == 200) {
      setState(() {
        bookings = jsonDecode(response.body) as List<dynamic>;
        isLoading = false;
      });
    } else {
      setState(() {
        errorText = 'Failed to load bookings: ${response.statusCode}';
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

  // Future<void> fetchBookings() async {
  //   setState(() {
  //     isLoading = true;
  //     errorText = null;
  //   });
  //   final url = Uri.parse(
  //     '${baseUrl}userapp/hospital/doctor/$doctorId/bookings/',
  //   );
  //   try {
  //     final response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         bookings = jsonDecode(response.body) as List<dynamic>;
  //         print('----$bookings');
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         errorText = 'Failed to load bookings';
  //         isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       errorText = 'Error: $e';
  //       isLoading = false;
  //     });
  //   }
  // }

  // String formatDate(String date) {
  //   // Expects "2025-11-01" and returns "November 01, 2025"
  //   try {
  //     final d = DateTime.parse(date);
  //     return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  //   } catch (_) {
  //     return date;
  //   }
  // }

  Future<void> updateBookingStatus(int bookingId, String status) async {
    final url = Uri.parse(
      '${baseUrl}userapp/hospital/booking/$bookingId/update-status/',
    );
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': status}),
      );
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Booking $status successfully'),
            backgroundColor: status == 'approved' ? Colors.green : Colors.red,
          ),
        );
        fetchBookings(); // Refresh list
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update status')),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      appBar: AppBar(
        title: const Text('My Appointments'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return HospaitalDocHomeScreen(doctorId: doctorId!);
                },
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body:
          isLoading
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
                    final currentStatus = appoint['status'] ?? 'booked';
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
                                    appoint['user_name'] ?? 'Unknown',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(
                                      currentStatus,
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    currentStatus.toUpperCase(),
                                    style: TextStyle(
                                      color: _getStatusColor(currentStatus),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
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
                            if (currentStatus == 'booked') ...[
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed:
                                          () => updateBookingStatus(
                                            appoint['id'],
                                            'rejected',
                                          ),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.red,
                                        side: const BorderSide(
                                          color: Colors.red,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: const Text("Reject"),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed:
                                          () => updateBookingStatus(
                                            appoint['id'],
                                            'approved',
                                          ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: const Text("Approve"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'booked':
      default:
        return Colors.orange;
    }
  }
}
