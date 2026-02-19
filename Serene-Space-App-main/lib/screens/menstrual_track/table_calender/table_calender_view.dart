import 'package:flutter/material.dart';
import 'package:serene_space_project/patient_screen/view_pie_chart.dart';
import 'package:table_calendar/table_calendar.dart';

class PeriodCalendarScreen extends StatefulWidget {
  final DateTime lastPeriodStart;
  final int cycleLength;
  final int periodLength;
  final int userId;

  const PeriodCalendarScreen({
    super.key,
    required this.lastPeriodStart,
    required this.cycleLength,
    required this.periodLength,
    required this.userId,
  });

  @override
  State<PeriodCalendarScreen> createState() => _PeriodCalendarScreenState();
}

class _PeriodCalendarScreenState extends State<PeriodCalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;

  Set<DateTime> periodDays = {};
  Set<DateTime> fertileDays = {};
  DateTime? ovulationDay;
  int? userId;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _firstDay = DateTime(DateTime.now().year - 1, 1, 1);
    _lastDay = DateTime(DateTime.now().year + 1, 12, 31);
    userId =widget.userId;
   // print('PeriodCalendarScreen =$userId');
    //print('Last Period Start: ${widget.lastPeriodStart}');
    //print('Cycle Length: ${widget.cycleLength}');
    //print('Period Length: ${widget.periodLength}');

    _calculateCycleDays();
  }

  void _calculateCycleDays() {
    periodDays.clear();
    fertileDays.clear();

    final start = widget.lastPeriodStart;

    // Add current period days
    for (int i = 0; i < widget.periodLength; i++) {
      periodDays.add(start.add(Duration(days: i)));
    }

    // Predict multiple cycles (e.g., next 3 months)
    for (int cycle = 0; cycle < 3; cycle++) {
      final cycleStart = start.add(Duration(days: cycle * widget.cycleLength));

      // Period days
      for (int i = 0; i < widget.periodLength; i++) {
        periodDays.add(cycleStart.add(Duration(days: i)));
      }

      // Ovulation day = cycleStart + (cycleLength - 14)
      final cycleOvulation = cycleStart.add(
        Duration(days: widget.cycleLength - 14),
      );

      // Save latest ovulation
      if (cycle == 0) ovulationDay = cycleOvulation;

      // Fertile window (5 days before ovulation + ovulation day)
      for (int i = 5; i >= 0; i--) {
        fertileDays.add(cycleOvulation.subtract(Duration(days: i)));
      }
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Period & Fertility Calendar'),
        backgroundColor: Colors.pink[100],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDEBEB), Color(0xFFFFF1F8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            TableCalendar(
              firstDay: _firstDay,
              lastDay: _lastDay,
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
                todayDecoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  // Highlight period days
                  if (periodDays.any((d) => _isSameDay(d, day))) {
                    return Container(
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.redAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  // Highlight fertile days
                  if (fertileDays.any((d) => _isSameDay(d, day))) {
                    return Container(
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.greenAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return null;
                },
                todayBuilder: (context, day, focusedDay) {
                  // Highlight ovulation day specially if today
                  if (ovulationDay != null && _isSameDay(ovulationDay!, day)) {
                    return Container(
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.orangeAccent, Colors.deepOrange],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return null;
                },
                selectedBuilder: (context, day, focusedDay) {
                  return Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                markerBuilder: (context, day, events) {
                  if (ovulationDay != null && _isSameDay(ovulationDay!, day)) {
                    return Positioned(
                      right: 4,
                      bottom: 4,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 35),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // ignore: deprecated_member_use
                _buildLegend(Colors.redAccent.withOpacity(0.5), 'Period Days'),
                const SizedBox(height: 15),
                _buildLegend(
                  // ignore: deprecated_member_use
                  Colors.greenAccent.withOpacity(0.5),
                  'Fertile Window',
                ),
                const SizedBox(height: 15),
                _buildLegend(Colors.deepOrangeAccent, 'Ovulation Day'),
              ],
            ),

            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final periodLen = widget.periodLength;
                  final fertileLen = fertileDays.length;
                  final ovulationLen = ovulationDay != null ? 1 : 0;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CyclePieChartPage(
                          periodLength: periodLen,
                          fertileLength: fertileLen,
                          ovulationLength: ovulationLen,
                          userId: userId!,
                        );
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  //  fixedSize:Size(40.0, 30.0) ,
                  backgroundColor: Colors.pink[200],
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
