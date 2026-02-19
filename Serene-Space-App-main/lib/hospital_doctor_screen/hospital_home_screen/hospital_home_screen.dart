import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
//import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:serene_space_project/authentication/patient/login_screen/login_view_page.dart';
import 'package:serene_space_project/hospital_doctor_screen/dochospital_create/dochospital_create_slot.dart';
import 'package:serene_space_project/hospital_doctor_screen/hospital_home_screen/view_patient_feedbacks.dart';
import 'package:serene_space_project/hospital_doctor_screen/hospital_home_screen/view_user_booking.dart';

class HospaitalDocHomeScreen extends StatefulWidget {
  const HospaitalDocHomeScreen({super.key,
   required this.doctorId
   });
  final int doctorId;
  @override
  State<HospaitalDocHomeScreen> createState() => _HospaitalDocHomeScreenState();
}

class _HospaitalDocHomeScreenState extends State<HospaitalDocHomeScreen>
    with SingleTickerProviderStateMixin {
  // final GlobalKey<SliderDrawerState> _sliderDrawerKey =
  //     GlobalKey<SliderDrawerState>();
  String title = "Medico Care";

  int _tabIndex = 2;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  int? doctorId;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
    doctorId = widget.doctorId;
  }
 Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout Alert"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog (No)
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog first
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              ); // Navigate to login (Yes)
            },
            child: const Text(
              "Yes, Logout",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
         SafeArea(
           child: Scaffold(
             extendBody: true,
            
             bottomNavigationBar: CircleNavBar(
              activeIcons: const [
    Icon(Icons.feedback_outlined, color: Colors.deepPurple),
    Icon(Icons.view_agenda, color: Colors.deepPurple),
    Icon(Icons.home, color: Colors.deepPurple),
    Icon(Icons.add, color: Colors.deepPurple),
    Icon(Icons.logout, color: Colors.deepPurple),
  ],
  inactiveIcons: const [
    Text("Feedback"),
    Text('Bookings'),
    Text("Home"),
    Text("Add Slots"),
    Text("Logout"),
  ],
               color: Colors.white,
               height: 60,
               circleWidth: 60,
               activeIndex: tabIndex,
               onTap: (index) {
                 tabIndex = index;
                 pageController.jumpToPage(tabIndex);
                 if (index == 0) {
                  // Navigate to My Booking page
                   Navigator.of(context).push(
                     MaterialPageRoute(
                       builder: (context) => HospitalDoctorFeedbackPage(doctorId: doctorId!,),
                     ),
                   );
                 }
                 else if (index == 1) {
                   // Navigate to Logout page OR perform logout then navigate
                   Navigator.of(context).pushReplacement(
                     MaterialPageRoute(builder: (context) => HosDoctorAppointmentsPage(doctorId: doctorId!,)),
                   );
                   // Or perform logout logic here then navigate
                 } 
                 else if (index == 2) {
                  //  // Navigate to Logout page OR perform logout then navigate
                  //  Navigator.of(context).pushReplacement(
                  //    MaterialPageRoute(builder: (context) => DoctorViewAppointments(doctorId: doctorId!,)),
                  //  );
                   // Or perform logout logic here then navigate
                 } else if (index == 3) {
                   // Navigate to Logout page OR perform logout then navigate
                   Navigator.of(context).pushReplacement(
                     MaterialPageRoute(builder: (context) => HospitalBookAppointmentScreen(doctorId:doctorId!,)),
                   );
                   // Or perform logout logic here then navigate
                 }
                 else if (index == 4){
                   _showLogoutDialog(context);
                 }
                 
               },
               padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
               cornerRadius: const BorderRadius.only(
                 topLeft: Radius.circular(8),
                 topRight: Radius.circular(8),
                 bottomRight: Radius.circular(24),
                 bottomLeft: Radius.circular(24),
               ),
               shadowColor: const Color.fromARGB(255, 248, 219, 175),
               elevation: 10,
             ),
             body: PageView(
               controller: pageController,
               onPageChanged: (v) {
                 tabIndex = v;
               },
               children: [
                 Container(
                   width: double.infinity,
                   height: double.infinity,
                   color: const Color.fromARGB(255, 158, 233, 225),
                 ),
                 Container(
                   width: double.infinity,
                   height: double.infinity,
                   color: const Color.fromARGB(255, 180, 210, 235),
                 ),
                 Container(
                   width: double.infinity,
                   height: double.infinity,
                   color: const Color.fromARGB(255, 162, 238, 209),
                 ),
                 Container(
                   width: double.infinity,
                   height: double.infinity,
                   color: const Color.fromARGB(255, 158, 233, 225),
                 ),
               ],
             ),
           ),
         ),
      ),
    );
  }

 
}
