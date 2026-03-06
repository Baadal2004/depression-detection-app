import 'package:flutter/material.dart';
import 'package:serene_space_project/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class NotificationHistoryScreen extends StatefulWidget {
  final int userId;
  const NotificationHistoryScreen({super.key, required this.userId});

  @override
  State<NotificationHistoryScreen> createState() => _NotificationHistoryScreenState();
}

class _NotificationHistoryScreenState extends State<NotificationHistoryScreen> {
  List<Map<String, dynamic>> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    // In a real app, this would be populated when a notification is received.
    // For this prototype, we'll show active habits that have notifications enabled.
    final String? habitsJson = prefs.getString('habits_${widget.userId}');
    if (habitsJson != null) {
      final List<dynamic> habits = json.decode(habitsJson);
      setState(() {
        notifications = habits
            .where((h) => h['isNotify'] == true)
            .map((h) => {
                  'title': 'Reminder: ${h['title']}',
                  'body': 'Set for every ${h['interval']} minutes',
                  'time': DateFormat('hh:mm a').format(DateTime.now()),
                  'icon': Icons.notifications_active,
                })
            .toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications", style: TextStyle(color: SereneTheme.darkPink)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: SereneTheme.darkPink),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_off_outlined, size: 80, color: Colors.grey[300]),
                      const SizedBox(height: 16),
                      const Text("No notifications yet", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final note = notifications[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: SereneTheme.lightPink,
                          child: Icon(note['icon'], color: SereneTheme.darkPink),
                        ),
                        title: Text(note['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(note['body']),
                        trailing: Text(note['time'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ),
                    );
                  },
                ),
    );
  }
}
