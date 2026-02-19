import 'package:flutter/material.dart';
import 'package:serene_space_project/hospital_doctor_screen/booking_history/booking_history_view.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int? selectedDate = 1;
  int? selectedTimeSlot;

  // Example dates
  final List<int> bookingDates = List.generate(30, (index) => index + 1);

  // Example time slots
  final List<String> timeSlots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left side image centered vertically
            SizedBox(
              width: 120,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://randomuser.me/api/portraits/men/11.jpg',
                    width: 100,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),

            // Right side details and booking
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dr. John Doe",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Cardiologist",
                    style: TextStyle(fontSize: 18, color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 18),

                  // Booking Dates as rectangle boxes
                  const Text(
                    "Booking Date:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: bookingDates.length > 15
                          ? 15
                          : bookingDates.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final date = bookingDates[index];
                        final isSelected = selectedDate == date;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate = date;
                              selectedTimeSlot = null; // reset time slot
                            });
                          },
                          child: Container(
                            width: 40,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.deepPurple
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.deepPurple
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    // ignore: deprecated_member_use
                                    color: Colors.deepPurple.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              date.toString(),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Time Slots for selected date
                  const Text(
                    "Select Time Slot:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: timeSlots.map((slot) {
                      final index = timeSlots.indexOf(slot);
                      final isSelected = selectedTimeSlot == index;
                      return ChoiceChip(
                        label: Text(slot),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedTimeSlot = selected ? index : null;
                          });
                        },
                        selectedColor: Colors.deepPurple,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }).toList(),
                  ),

                  const Spacer(),

                  // Book Now Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          (selectedDate != null && selectedTimeSlot != null)
                          ? () {
                              // Implement booking action here
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Booked for date $selectedDate at ${timeSlots[selectedTimeSlot!]}',
                                  ),
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AppointmentDetailsScreen();
                                  },
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
