import 'package:flutter/material.dart';
import 'package:serene_space_project/hospital_doctor_screen/doctor_view_appointment.dart';

class Doctor {
  final String imageUrl;
  final String name;
  final String qualification;
  final String specialization;
  // Extra hospital info
  final String hospitalLocation;
  final String hospitalPlace;
  final String hospitalAddress;
  final String hospitalPhone;
  final double starRating;
  final String feedback;

  Doctor({
    required this.imageUrl,
    required this.name,
    required this.qualification,
    required this.specialization,
    required this.hospitalLocation,
    required this.hospitalPlace,
    required this.hospitalAddress,
    required this.hospitalPhone,
    required this.starRating,
    required this.feedback,
  });
}

// Example data
final List<Doctor> doctors = [
  Doctor(
    imageUrl: "https://randomuser.me/api/portraits/men/11.jpg",
    name: "Dr. John Doe",
    qualification: "MBBS, MD",
    specialization: "Cardiologist",
    hospitalLocation: "City Center",
    hospitalPlace: "Apollo Hospital",
    hospitalAddress: "123 Main Street, Springfield",
    hospitalPhone: "+1 234 567 890",
    starRating: 4.5,
    feedback: "Excellent care and friendly staff.",
  ),
  Doctor(
    imageUrl: "https://randomuser.me/api/portraits/women/12.jpg",
    name: "Dr. Jane Smith",
    qualification: "MBBS, MS",
    specialization: "Surgeon",
    hospitalLocation: "Downtown",
    hospitalPlace: "City Hospital",
    hospitalAddress: "456 Elm Street, Springfield",
    hospitalPhone: "+1 987 654 321",
    starRating: 4.2,
    feedback: "Very professional and attentive.",
  ),
  // Add more with hospital info as needed...
];

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});
  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctors List')),
      body: Padding( 
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.7,
          children: doctors.map((doctor) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        doctor.imageUrl,
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // const SizedBox(height: 6),
                    // Text(
                    //   doctor.qualification,
                    //   style: const TextStyle(
                    //     color: Colors.blueGrey,
                    //     fontSize: 15,
                    //   ),
                    // ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialization,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // print
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HospitalDetailsScreen(doctor: doctor),
                          ),
                        );
                      },
                      child: const Text('View'),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class HospitalDetailsScreen extends StatelessWidget {
  final Doctor doctor;

  const HospitalDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${doctor.name} - Hospital Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctor.hospitalPlace,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${doctor.hospitalLocation}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              'Address: ${doctor.hospitalAddress}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              'Phone: ${doctor.hospitalPhone}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Rating:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                ...List.generate(
                  5,
                  (index) => Icon(
                    index < doctor.starRating.floor()
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                  ),
                ),
                if (doctor.starRating % 1 >= 0.5)
                  const Icon(Icons.star_half, color: Colors.amber),
                const SizedBox(width: 8),
                Text(
                  '${doctor.starRating}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Feedback:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              doctor.feedback,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 30), // spacing before button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookingScreen()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Text(
                    'Get Appointment',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
