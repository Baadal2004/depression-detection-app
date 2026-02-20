import 'package:flutter/material.dart';
import 'package:serene_space_project/hospital_doctor_screen/dochospital_create/dochospital_create_slot.dart';
import 'package:serene_space_project/hospital_doctor_screen/hospital_home_screen/view_patient_feedbacks.dart';
import 'package:serene_space_project/hospital_doctor_screen/hospital_home_screen/view_user_booking.dart';

class DoctorDashboard extends StatelessWidget {
  final int doctorId;

  const DoctorDashboard({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Header Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome,",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Text(
                      "Doctor!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D2445),
                      ),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/smiling-pretty-woman-doctor-with-tablet.jpg'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            
            // Stats Section
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: "Appointments",
                    value: "12",
                    icon: Icons.calendar_today_rounded,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: "Total Patients",
                    value: "45",
                    icon: Icons.people_rounded,
                    color: Colors.orangeAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: "Feedbacks",
                    value: "28",
                    icon: Icons.rate_review_rounded,
                    color: Colors.greenAccent,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: "Satisfaction",
                    value: "98%",
                    icon: Icons.favorite_rounded,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Quick Actions
            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D2445),
              ),
            ),
            const SizedBox(height: 15),
            _buildActionTile(
              context,
              title: "Manage Appointments",
              subtitle: "View and update booking status",
              icon: Icons.view_agenda_rounded,
              color: Colors.indigo,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HosDoctorAppointmentsPage(doctorId: doctorId)),
                );
              },
            ),
            _buildActionTile(
              context,
              title: "Create Time Slots",
              subtitle: "Open new availability for patients",
              icon: Icons.add_alarm_rounded,
              color: Colors.teal,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HospitalBookAppointmentScreen(doctorId: doctorId)),
                );
              },
            ),
            _buildActionTile(
              context,
              title: "Patient Feedbacks",
              subtitle: "See what your patients are saying",
              icon: Icons.chat_bubble_rounded,
              color: Colors.amber[800]!,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HospitalDoctorFeedbackPage(doctorId: doctorId)),
                );
              },
            ),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 15),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D2445),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D2445),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
