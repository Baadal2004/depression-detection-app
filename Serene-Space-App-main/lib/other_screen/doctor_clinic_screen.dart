import 'package:flutter/material.dart';
import 'package:serene_space_project/authentication/doctor_authentication/doctor_login/doctor_login_view.dart';

class FindDoctorPage extends StatelessWidget {
  const FindDoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFF), // Soft pastel background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        title: const Text(
          "Find a Doctor",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDoctorCard(
              context,
              title: "Hospital Doctor",
              imagePath: "assets/images/doc_image.jpg", // 🏥 hospital image
              icon: Icons.local_hospital_outlined,
              iconColor: const Color(0xFF00A389), // pastel green-blue
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                     return DoctorLoginScreen();
                    },
                  ),
                );
              },
            ),
            // const SizedBox(height: 24),
            // _buildDoctorCard(
            //   context,
            //   title: "Clinic Doctor",
            //   imagePath: "assets/images/cli.jpg", // 🏩 clinic image
            //   icon: Icons.favorite_rounded,
            //   iconColor: const Color(0xFF3478F6), // soft blue
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return ClinicLoginScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard(
    BuildContext context, {
    required String title,
    required String imagePath,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
          // image: DecorationImage(
          //   image: AssetImage(imagePath),
          //   fit: BoxFit.cover,
          //   colorFilter: ColorFilter.mode(
          //     Colors.white.withOpacity(0.7),
          //     BlendMode.lighten,
          //   ),
          // ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Transform.rotate(
                angle: 3.1416, // 180 degrees in radians
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
              // ignore: deprecated_member_use
              Container(color: Colors.white.withOpacity(0.6)),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: Icon(icon, size: 30, color: iconColor),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
