import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serene_space_project/screens/menstrual_track/input_cycle/bloc/input_cycle_bloc.dart';
import 'package:serene_space_project/screens/menstrual_track/input_cycle/habit_tracker_screen.dart';

class PeriodInputScreen extends StatefulWidget {
  const PeriodInputScreen({super.key, required this.userId, this.name = ''});
  final int userId;
  final String name;

  @override
  // ignore: library_private_types_in_public_api
  _PeriodInputScreenState createState() => _PeriodInputScreenState();
}

class _PeriodInputScreenState extends State<PeriodInputScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  final sleepController = TextEditingController();
  final screenTimeController = TextEditingController();
  final phoneUnlockController = TextEditingController();
  final memoryScoreController = TextEditingController();
  // final nameController = TextEditingController();
  final ageController = TextEditingController();
  String gender = "Male";
  int? userId;

  // ADHD scores (0–3)
  int easilyDistracted = 0;
  int forgetfulDailyTasks = 0;
  int poorOrganization = 0;
  int difficultyAttention = 0;
  int restlessness = 0;
  int impulsivityScore = 0;
  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    //print('PeriodInputScreen=$userId');
  }

  DropdownButtonFormField<int> scoreDropdown(
    String label,
    int value,
    List<String> meanings,
    Function(int?) onChanged,
  ) {
    return DropdownButtonFormField<int>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      ),
      items: List.generate(4, (index) {
        return DropdownMenuItem(
          value: index,
          child: Text("$index – ${meanings[index]}"),
        );
      }),
      onChanged: onChanged,
    );
  }

  Future<void> submitDetails() async {
    if (!_formKey.currentState!.validate()) return;

    const adhdTextMap = ["never", "mild", "often", "very often"];

    FocusScope.of(context).unfocus();

    context.read<InputCycleBloc>().add(
      InputCycleEvent.predictADHD(
        userId: widget.userId,
        age: int.parse(ageController.text.trim()),
        gender: gender,
        sleepingHour: double.parse(sleepController.text.trim()),

        distracted: adhdTextMap[easilyDistracted],
        forgetful: adhdTextMap[forgetfulDailyTasks],
        poorOrganization: adhdTextMap[poorOrganization],
        sustainingAttention: adhdTextMap[difficultyAttention],
        restlessness: adhdTextMap[restlessness],
        impulsivityScore: adhdTextMap[impulsivityScore],

        screenTime: double.parse(screenTimeController.text.trim()),
        phoneUnlocks: double.parse(phoneUnlockController.text.trim()), // ✅ FIX
        workingHour: double.parse(memoryScoreController.text.trim()), // ✅ FIX
      ),
    );
  }
 void _showNoAdhdDetectedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("No ADHD Detected"),
          content: const Text(
            "Based on your assessment, you may not have ADHD.\n\n"
             ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HabitTrackerScreen(
                      isAdhdDetected: false,
                      userId: userId!,
                    ),
                  ),
                );
              },
              child: const Text("Habit Tracker & Suggestions"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                 Navigator.pop(context);  // close first dialog
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
  void _showAdhdDetectedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("ADHD Detected"),
          content: const Text(
            "Based on your assessment, you may have ADHD.\n\n"
            "Don’t worry. ADHD can be managed with proper lifestyle changes.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close first dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HabitTrackerScreen(
                      isAdhdDetected: true,
                      userId: userId!,
                    ),
                  ),
                );
              },
              child: const Text("Habit Tracker & Suggestions"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close first dialog
                _showAdhdSolutionDialog(context); // open second dialog
              },
              child: const Text("View Solutions"),
            ),
          ],
        );
      },
    );
  }

  void _showAdhdSolutionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Managing ADHD Naturally"),
          content: const SingleChildScrollView(
            child: Text(
              "Here are some proven ways to manage ADHD:\n\n"
              "🧘 Yoga & Meditation\n"
              "• Practice Pranayama daily\n"
              "• Try mindfulness meditation (10–15 mins)\n\n"
              "🏃 Physical Activity\n"
              "• Daily walking or light exercise\n\n"
              "🕰 Routine Management\n"
              "• Fixed sleep & wake time\n"
              "• Break tasks into small steps\n\n"
              "📵 Digital Control\n"
              "• Reduce screen time\n"
              "• Limit phone usage\n\n"
              "🥗 Nutrition\n"
              "• Eat healthy food\n"
              "• Avoid excess sugar & caffeine\n\n"
              "📘 Professional Support\n"
              "• Cognitive Behavioral Therapy (CBT)\n"
              "• Counseling if needed",
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // exit ADHD screen
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Color.fromARGB(255, 177, 11, 66),
          ),
        ),
        title: const Text('ADHD Predictor'),
        backgroundColor: Colors.pink[100],
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HabitTrackerScreen(
                    isAdhdDetected: false, // Default to false if accessed directly
                    userId: userId!,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.track_changes, color: Color.fromARGB(255, 177, 11, 66)),
          ),
        ],
      ),
      body: BlocConsumer<InputCycleBloc, InputCycleState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {
              setState(() => isloading = true);
            },
            success: (response) {
              setState(() => isloading = false);

              final result = response.adhdResult.trim().toUpperCase();

              if (result == "ADHD") {
                _showAdhdDetectedDialog(context);
              } else {
                _showNoAdhdDetectedDialog(context);
              }
            },
            error: (error) {
              setState(() => isloading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error), backgroundColor: Colors.red),
              );
            },
          );
        },

        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Last day of periods (date picker)
                //  TextFormField(
                //   controller: nameController,
                //   keyboardType: TextInputType.name,
                //   decoration: const InputDecoration(
                //     labelText: "Name",
                //     border: OutlineInputBorder(),
                //   ),
                //   validator: (v) => v!.isEmpty ? "Enter Name" : null,
                // ),
                // const SizedBox(height: 16),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Age",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? "Enter age" : null,
                ),
                const SizedBox(height: 16),

                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      "Gender:",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),

                    Radio<String>(
                      value: "Male",
                      // ignore: deprecated_member_use
                      groupValue: gender,
                      // ignore: deprecated_member_use
                      onChanged: (v) => setState(() => gender = v!),
                    ),
                    const Text("Male"),

                    Radio<String>(
                      value: "Female",
                      // ignore: deprecated_member_use
                      groupValue: gender,
                      // ignore: deprecated_member_use
                      onChanged: (v) => setState(() => gender = v!),
                    ),
                    const Text("Female"),

                    Radio<String>(
                      value: "Other",
                      // ignore: deprecated_member_use
                      groupValue: gender,
                      // ignore: deprecated_member_use
                      onChanged: (v) => setState(() => gender = v!),
                    ),
                    const Text("Other"),
                  ],
                ),

                const SizedBox(height: 24),

                SizedBox(height: 8),
                scoreDropdown(
                  "Easily Distracted",
                  easilyDistracted,
                  [
                    "Not distracted",
                    "Mildly distracted",
                    "Often distracted",
                    "Very easily distracted",
                  ],
                  (v) => setState(() => easilyDistracted = v!),
                ),
                const SizedBox(height: 16),

                // 2. Forgetful
                scoreDropdown(
                  "Forgetful Daily Tasks",
                  forgetfulDailyTasks,
                  [
                    "Never forgets",
                    "Sometimes forgets",
                    "Often forgets",
                    "Forgets very often",
                  ],
                  (v) => setState(() => forgetfulDailyTasks = v!),
                ),
                const SizedBox(height: 16),

                // 3. Organization
                scoreDropdown(
                  "Poor Organization",
                  poorOrganization,
                  [
                    "Very organized",
                    "Slightly disorganized",
                    "Moderately poor",
                    "Very poor organization",
                  ],
                  (v) => setState(() => poorOrganization = v!),
                ),
                const SizedBox(height: 16),

                // 4. Attention
                scoreDropdown(
                  "Difficulty Sustaining Attention",
                  difficultyAttention,
                  [
                    "No issues",
                    "Mild difficulty",
                    "Moderate difficulty",
                    "Severe difficulty",
                  ],
                  (v) => setState(() => difficultyAttention = v!),
                ),
                const SizedBox(height: 16),

                // 5. Restlessness
                scoreDropdown(
                  "Restlessness",
                  restlessness,
                  [
                    "Calm",
                    "Mild restlessness",
                    "Often restless",
                    "Very restless",
                  ],
                  (v) => setState(() => restlessness = v!),
                ),
                const SizedBox(height: 16),

                // 6. Impulsivity
                scoreDropdown(
                  "Impulsivity",
                  impulsivityScore,
                  [
                    "Not impulsive",
                    "Mild impulsivity",
                    "Often impulsive",
                    "Very impulsive",
                  ],
                  (v) => setState(() => impulsivityScore = v!),
                ),
                const SizedBox(height: 24),

                // 7. Sleep
                TextFormField(
                  controller: sleepController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Average Sleep Hours (4–10)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),

                // 8. Screen time
                TextFormField(
                  controller: screenTimeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Daily Screen Time (1–10 hrs)",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // 9. Phone unlocks
                TextFormField(
                  controller: phoneUnlockController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Phone Unlocks Per Day (20–200)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Required";
                    final val = int.tryParse(v);
                    if (val == null) return "Enter valid number";
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // 10. Memory
                TextFormField(
                  controller: memoryScoreController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Working Memory Score (20–80)",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submitDetails();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[200],
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Predict ADHD'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


