import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:serene_space_project/constant_uri.dart';
import 'package:serene_space_project/utils/app_theme.dart';

class HospitalDoctorFeedbackPage extends StatefulWidget {
  final int doctorId;
  const HospitalDoctorFeedbackPage({super.key, required this.doctorId});

  @override
  State<HospitalDoctorFeedbackPage> createState() => _HospitalDoctorFeedbackPageState();
}

class _HospitalDoctorFeedbackPageState extends State<HospitalDoctorFeedbackPage> {
  List<dynamic> feedbacks = [];
  bool isLoading = true;
  String? errorText;
  int? doctorId;

  @override
  void initState() {
    super.initState();
    fetchFeedbacks();
    doctorId = widget.doctorId;
  }

  Future<void> fetchFeedbacks() async {
    setState(() {
      isLoading = true;
      errorText = null;
    });
    final url = Uri.parse(
      '${baseUrl}userapp/hospital/doctor/${widget.doctorId}/feedback/',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          feedbacks = jsonDecode(response.body) as List<dynamic>;
          isLoading = false;
        });
      } else {
        setState(() {
          errorText = 'Failed to load feedback';
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

  // String formatDate(String dateTimeString) {
  //   try {
  //     DateTime dt = DateTime.parse(dateTimeString);
  //     return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  //   } catch (_) {
  //     return dateTimeString;
  //   }
  // }
String formatDate(String dateStr) {
    final date = DateTime.parse(dateStr); // "2025-11-01"
    return DateFormat('dd-MM-yyyy').format(date);
  }

  Widget buildRatingStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorText != null
          ? Center(child: Text(errorText!))
          : feedbacks.isEmpty
          ? const Center(child: Text('No feedback found'))
          : ListView.builder(
              itemCount: feedbacks.length,
              itemBuilder: (context, index) {
                final fb = feedbacks[index];
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              fb['user_name'] ?? 'Unknown User',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color(0xFF18214A),
                              ),
                            ),
                            if (fb['booking_date'] != null)
                              Text(
                                "Session: ${formatDate(fb['booking_date'])}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: SereneTheme.darkPink,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            buildRatingStars(fb['rating'] ?? 0),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: SereneTheme.lightPink.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Tension-Free: ${fb['tension_free_level']}/10",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SereneTheme.darkPink,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          fb['comments'] ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF222B45),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Submitted on: ${fb['created_at'] != null ? DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(fb['created_at'])) : 'N/A'}",
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF8898AD),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
