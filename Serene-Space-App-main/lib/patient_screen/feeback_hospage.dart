import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:serene_space_project/constant_uri.dart';
import 'package:serene_space_project/patient_screen/view_my_hosbooking.dart';

class HosFeedbackPage extends StatefulWidget {
  const HosFeedbackPage({super.key, required this.userid, this.doctorId});
  final int? userid;
  final int? doctorId;

  @override
  HosFeedbackPageState createState() => HosFeedbackPageState();
}

class HosFeedbackPageState extends State<HosFeedbackPage> {
  double rating = 0;
  int? userId;
  int? doctorId;
  TextEditingController feedbackController = TextEditingController();
  @override
  void initState() {
    super.initState();
    userId = widget.userid;
    doctorId = widget.doctorId;
  }

  Future<void> submitFeedback() async {
    if (feedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your feedback.")),
      );
      return;
    }

    // Backend API URL
    final apiUrl = Urlsss.userHosFeedback; // Replace with your actual API endpoint

    // Data to be sent
    Map<String, dynamic> feedbackData = {
      "user": userId,
      "doctor": doctorId,
      // Replace with dynamic user ID if needed
      "rating": rating,
      "comments": feedbackController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(feedbackData),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        showSuccess("Feedback submitted successfully!");

        feedbackController.clear();
        setState(() {
          rating = 0; // Reset rating after submission
        });
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return HosDoctorAppointmentsPages(userId: userId!,);
            },
          ),
        );
      } else {
        showError("Failed to submit feedback: ${response.body}");
      }
    } catch (e) {
      showError("Error: $e");
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Feedback"),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Rate Our Service",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (ratingValue) {
                setState(() {
                  rating = ratingValue;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Your Feedback",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: feedbackController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Write your feedback here...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: submitFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Submit Feedback",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
