import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serene_space_project/constant_uri.dart';
import 'package:serene_space_project/utils/app_theme.dart';

class FeedbackFormScreen extends StatefulWidget {
  final int userId;
  final int doctorId;
  final int bookingId;
  final String doctorName;

  const FeedbackFormScreen({
    super.key,
    required this.userId,
    required this.doctorId,
    required this.bookingId,
    required this.doctorName,
  });

  @override
  State<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  int _rating = 0;
  double _tensionFreeLevel = 5.0;
  final TextEditingController _commentsController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitFeedback() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide a rating')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final url = Uri.parse('${baseUrl}userapp/user-hospital/doctor/feedback/add/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user': widget.userId,
          'doctor': widget.doctorId,
          'booking': widget.bookingId,
          'rating': _rating,
          'tension_free_level': _tensionFreeLevel.toInt(),
          'comments': _commentsController.text,
        }),
      );

      if (response.statusCode == 201) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback submitted successfully!')),
        );
        Navigator.pop(context);
      } else {
        throw Exception('Failed to submit feedback');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Consultation Feedback'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: SereneTheme.darkPink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How was your session with",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Dr. ${widget.doctorName}?",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: SereneTheme.darkPink,
              ),
            ),
            const SizedBox(height: 40),
            
            const Text(
              "Rating",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: index < _rating ? Colors.amber : Colors.grey[400],
                    size: 48,
                  ),
                  onPressed: () => setState(() => _rating = index + 1),
                );
              }),
            ),
            const SizedBox(height: 40),

            const Text(
              "How 'tension-free' do you feel now?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "1 = Very Tense, 10 = Completely Relaxed",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: SereneTheme.primaryPink,
                inactiveTrackColor: SereneTheme.lightPink,
                thumbColor: SereneTheme.darkPink,
                overlayColor: SereneTheme.primaryPink.withAlpha(32),
                valueIndicatorColor: SereneTheme.darkPink,
                valueIndicatorTextStyle: const TextStyle(color: Colors.white),
              ),
              child: Slider(
                value: _tensionFreeLevel,
                min: 1,
                max: 10,
                divisions: 9,
                label: _tensionFreeLevel.round().toString(),
                onChanged: (value) => setState(() => _tensionFreeLevel = value),
              ),
            ),
            const SizedBox(height: 40),

            const Text(
              "Additional Comments",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentsController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Share your experience...",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: SereneTheme.darkPink,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Submit Feedback",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
