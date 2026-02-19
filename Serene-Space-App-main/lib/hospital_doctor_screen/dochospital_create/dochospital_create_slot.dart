import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:serene_space_project/hospital_doctor_screen/dochospital_create/bloc/bloc_bloc.dart';
import 'package:serene_space_project/hospital_doctor_screen/hospital_home_screen/hospital_home_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:serene_space_project/constant_uri.dart';

class HospitalBookAppointmentScreen extends StatefulWidget {
  const HospitalBookAppointmentScreen({super.key, required this.doctorId});
  final int doctorId; // Example clinic doctor ID
  @override
  State<HospitalBookAppointmentScreen> createState() => _HospitalBookAppointmentScreenState();
}

class _HospitalBookAppointmentScreenState extends State<HospitalBookAppointmentScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? startTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay? endTime = TimeOfDay(hour: 17, minute: 0);
  Set<String> selectedSlots = {};
  int? doctorId;
  bool availability = true; // Green: true, Red: false
  Map<String, dynamic>? doctorDetails;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = false;

  final List<String> slots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '01:00 PM',
    '01:30 PM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
    '05:30 PM',
    '06:00 PM',
    '06:30 PM',
    '07:00 PM',
    '07:30 PM',
    '08:00 PM',
    '08:30 PM',
    '09:00 PM',
    '09:30 PM',
    '10:00 PM',
  ];
  @override
  void initState() {
    super.initState();
    doctorId = widget.doctorId;
    getDoctorDetails();
  }

  String formatTimeOfDay24Hr(TimeOfDay tod) {
    final hour = tod.hour.toString().padLeft(2, '0');
    final minute = tod.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }
String convertTo24HourNoSuffix(String time) {
  final parts = time.split(RegExp(r'[: ]'));
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);
  final period = parts[2];
  if (period == 'PM' && hour != 12) hour += 12;
  if (period == 'AM' && hour == 12) hour = 0;
  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

  Future<void> confirmSlot() async {
   // print(123);
    FocusScope.of(context).unfocus();
    setState(() {
      isloading = true;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }
    setState(() {
      isloading = true;
    });
   // print('after validation');

    if (selectedSlots.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select at least one slot')),
      );
      return;
    }
    context.read<BlocBloc>().add(
  BlocEvent.uploadSlots(
    clinicDoctor: doctorId!,
    date: DateFormat('yyyy-MM-dd').format(selectedDate),
    startTime: formatTimeOfDay24Hr(startTime!),
    endTime: formatTimeOfDay24Hr(endTime!),
    timeslots: selectedSlots.map(convertTo24HourNoSuffix).toList(),
  ),
);

  }

  Future<void> postAvailability(bool available) async {
    final url = Uri.parse(
      "${baseUrl}userapp/hospital-doctor/$doctorId/availability/",
    );
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'available': available}),
    );
     if (response.statusCode == 200 || response.statusCode == 201) {
      final resp = jsonDecode(response.body);
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text(resp['message'])));
    } else {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('Backend error!')));
    }
  }

  Future<void> getDoctorDetails() async {
    final url = Uri.parse(
      '${baseUrl}userapp/view_hospital_doctor/$doctorId/',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        doctorDetails = data;
      });
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final hour = tod.hourOfPeriod == 0 ? 12 : tod.hourOfPeriod;
    final minute = tod.minute.toString().padLeft(2, '0');
    final period = tod.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }

  TimeOfDay parseTimeOfDay(String timeString) {
    final parts = timeString.split(RegExp('[: ]'));
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    String period = parts[2];
    if (period == 'PM' && hour != 12) hour += 12;
    if (period == 'AM' && hour == 12) hour = 0;
    return TimeOfDay(hour: hour, minute: minute);
  }

  List<String> get filteredSlots {
    if (startTime == null || endTime == null) return [];
    List<String> result = [];
    int startMinutes = startTime!.hour * 60 + startTime!.minute;
    int endMinutes = endTime!.hour * 60 + endTime!.minute;
    for (String slot in slots) {
      TimeOfDay t = parseTimeOfDay(slot);
      int slotMinutes = t.hour * 60 + t.minute;
      if (slotMinutes >= startMinutes && slotMinutes <= endMinutes) {
        result.add(slot);
      }
    }
    return result;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedule Availability',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF4F6FC),
      body: BlocConsumer<BlocBloc, BlocState>(
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return  HospaitalDocHomeScreen(doctorId: doctorId!,);
                  },
                ),
              );
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
          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(blurRadius: 16, color: Colors.black12),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading:
                              doctorDetails != null &&
                                  doctorDetails!['image'] != null &&
                                  doctorDetails!['image'].toString().isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    doctorDetails!['image']
                                            .toString()
                                            .startsWith('http')
                                        ? doctorDetails!['image']
                                        : '${baseUrl}${doctorDetails!['image'].startsWith('/') ? doctorDetails!['image'].substring(1) : doctorDetails!['image']}',
                                  ),
                                  radius: 20,
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.purple[100],
                                  radius: 20,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                          title: Text(
                            doctorDetails != null &&
                                    doctorDetails!['name'] != null
                                ? doctorDetails!['name']
                                : '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          contentPadding: EdgeInsets.all(0),
                          trailing: Column(
                            children: [
                              Text('Availability'),
                              ToggleSwitch(
                                minWidth: 35.0,
                                cornerRadius: 40.0,
                                activeBgColors: [
                                  [Colors.red[800]!],
                                  [Colors.green[800]!],
                                ],
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.grey,
                                inactiveFgColor: Colors.white,
                                initialLabelIndex: availability ? 1 : 0,
                                totalSwitches: 2,
                                labels: ['False', 'True'],
                                radiusStyle: true,
                                onToggle: (index) async {
                                  setState(() {
                                    availability = index == 1;
                                  });
                                  await postAvailability(availability);
                                },
                              ),
                            ],
                          ),
                        ),
                        // Only show fields if availability is ON/true
                        if (availability) ...[
                          SizedBox(height: 16),
                          Text(
                            'Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () async {
                              selectDate(context);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat(
                                      'dd-MM-yyyy',
                                    ).format(selectedDate),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Icon(Icons.calendar_today_outlined),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Start Time',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    GestureDetector(
                                      onTap: () async {
                                        TimeOfDay? picked =
                                            await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  startTime ??
                                                  TimeOfDay(hour: 9, minute: 0),
                                            );
                                        if (picked != null) {
                                          setState(() => startTime = picked);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 14,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              startTime != null
                                                  ? formatTimeOfDay(startTime!)
                                                  : 'Select',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Spacer(),
                                            Icon(Icons.access_time_outlined),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'End Time',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    GestureDetector(
                                      onTap: () async {
                                        TimeOfDay? picked =
                                            await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  endTime ??
                                                  TimeOfDay(
                                                    hour: 17,
                                                    minute: 0,
                                                  ),
                                            );
                                        if (picked != null) {
                                          setState(() => endTime = picked);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 14,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              endTime != null
                                                  ? formatTimeOfDay(endTime!)
                                                  : 'Select',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Spacer(),
                                            Icon(Icons.access_time_outlined),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 22),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Create Slots Window',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 13,
                            mainAxisSpacing: 16,
                            childAspectRatio: 2,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: filteredSlots.map((slot) {
                              bool isSelected = selectedSlots.contains(slot);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedSlots.remove(slot);
                                    } else {
                                      selectedSlots.add(slot);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2,
                                    vertical: 10,
                                  ), // tighter padding
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: isSelected
                                        ? Border.all(
                                            color: Colors.greenAccent,
                                            width: 2,
                                          )
                                        : null,
                                    color: isSelected
                                        ? Colors.white
                                        : Color(0xFF8F7BF6),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: Colors.greenAccent
                                                  // ignore: deprecated_member_use
                                                  .withOpacity(0.1),
                                              blurRadius: 12,
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween, // prevents overflow
                                    children: [
                                      Flexible(
                                        child: Text(
                                          slot,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12, // tighter font
                                            color: isSelected
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                      if (isSelected)
                                        Padding(
                                          padding: EdgeInsets.only(left: 2),
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 16, // smaller icon to fit
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 32),
                          ElevatedButton.icon(
                            icon: Icon(Icons.check, color: Colors.white),
                            label: Text(
                              'Confirm Slots',
                              style: TextStyle(fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF8F7BF6),
                              minimumSize: Size(double.infinity, 52),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              elevation: 0,
                            ),
                            onPressed: confirmSlot,
                          ),
                        ], // End conditional availability fields
                      ],
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
