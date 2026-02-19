import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serene_space_project/patient_screen/book_now_hos_screen/book_now_view.dart';
import 'package:serene_space_project/patient_screen/list_nearbyhos_doc/bloc/list_nearbyhos_bloc.dart';
import 'package:serene_space_project/patient_screen/list_nearbyhos_doc/list_nearbyhos_doc_model.dart';
import 'package:serene_space_project/constant_uri.dart';

class FindHosDoctorScreen extends StatefulWidget {
  const FindHosDoctorScreen({super.key, required this.userId});
  final int userId;

  @override
  State<FindHosDoctorScreen> createState() => _FindHosDoctorScreenState();
}

class _FindHosDoctorScreenState extends State<FindHosDoctorScreen> {
  int? userId;
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    userId = widget.userId;
  //  print('userId in find doctor screen: $userId');
    fetchClinicDoc();
  }

  String getAbsoluteImageUrl(String imagePath) {
    if (imagePath.startsWith('http')) return imagePath;
    return "${baseUrl}${imagePath.startsWith('/') ? imagePath.substring(1) : imagePath}";
  }

  Future<void> fetchClinicDoc() async {
    context.read<ListNearbyhosBloc>().add(
      ListNearbyhosEvent.nearbydoc(userId: userId!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 8),
          child: Text(
            "Find Hospital Doctors",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Color(0xFF18214A),
            ),
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(top: 15.0, right: 18),
        //     child: Icon(Icons.search, color: Colors.grey[700], size: 28),
        //   ),
        // ],
      ),
      body: BlocConsumer<ListNearbyhosBloc, ListNearbyhosState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {
              setState(() => isloading = true);
            },
            success: (response) {
              setState(() => isloading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Registration Successful"),
                  backgroundColor: Colors.green,
                ),
              );
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return const ();
              //     },
              //   ),
              // );
            },
            error: (error) {
              setState(() => isloading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error: $error"),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (doctors) {
              if (doctors.isEmpty) {
                return const Center(child: Text("No doctors found nearby."));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return DoctorCard(
                    doctor: doctor,
                    getAbsoluteImageUrl: getAbsoluteImageUrl,
                    userId: userId!,
                  );
                },
              );
            },
            orElse: () =>
                const Center(child: Text("Please search for doctors.")),
          );
        },
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final NearbyHosDoctor doctor;
  final String Function(String) getAbsoluteImageUrl;
  final int userId;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.getAbsoluteImageUrl,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    // final openColor = doctor.isOpen ? Color(0xFFB9EDD1) : Color(0xFFEDE5F5);
    // final openTextColor = doctor.isOpen ? Color(0xFF22BE8A) : Color(0xFF8E84C7);

    return Card(
      elevation: 1,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 31,
              backgroundColor: const Color(0xFFF7F3F9),
              backgroundImage: NetworkImage(getAbsoluteImageUrl(doctor.image)),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.hospitalName ?? 'Unknown Clinic',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      doctor.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color(0xFF18214A),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${doctor.specialization} ",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                        fontSize: 15,
                      ),
                    ),
                    // SizedBox(height: 12),
                    // Row(
                    //   children: [
                    //     Container(
                    //       decoration: BoxDecoration(
                    //         color: openColor,
                    //         borderRadius: BorderRadius.circular(22),
                    //       ),
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 14,
                    //         vertical: 6,
                    //       ),
                    //       child: Row(
                    //         children: [
                    //           Icon(
                    //             doctor.isOpen
                    //                 ? Icons.check_circle
                    //                 : Icons.cancel,
                    //             size: 18,
                    //             color: openTextColor,
                    //           ),
                    //           SizedBox(width: 6),
                    //           Text(
                    //             doctor.isOpen ? "Open" : "Closed",
                    //             style: TextStyle(
                    //               color: openTextColor,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     SizedBox(width: 14),
                    //     Row(
                    //       children: [
                    //         Icon(
                    //           Icons.star_rounded,
                    //           color: Color(0xFFFFBD4D),
                    //           size: 20,
                    //         ),
                    //         SizedBox(width: 2),
                    //         Text(
                    //           doctor.rating.toStringAsFixed(1),
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.w600,
                    //             color: Color(0xFF18214A),
                    //             fontSize: 15,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF41C6AC),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                onPressed: () {
                  /* Book action */
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BookNowHosScreen(
                          doctorId: doctor.id,
                          userId: userId,
                        );
                      },
                    ),
                  );
                },
                child: Text("View"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
