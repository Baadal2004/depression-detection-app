import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:serene_space_project/authentication/patient/login_screen/login_view_page.dart';
import 'package:serene_space_project/constant_uri.dart';
import 'package:serene_space_project/patient_screen/home_screen.dart';
import 'package:serene_space_project/patient_screen/list_nearbyhos_doc/list_nearbyhos_doc_view.dart';
import 'package:serene_space_project/patient_screen/pcod_prediction/input_condition_datas.dart/input_condition_service.dart';
import 'package:serene_space_project/screens/chatbot/chatbot.dart';
import 'package:serene_space_project/utils/app_theme.dart';


class HealthProfileScreen extends StatefulWidget {
  const HealthProfileScreen({super.key, required this.userId});
  final int userId;

  @override
  State<HealthProfileScreen> createState() => _HealthProfileScreenState();
}

class _HealthProfileScreenState extends State<HealthProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Answers
  int? gender;
  double? age;
  int? educationLevel;
  int? employmentStatus;
  int? depressionType;
  int? symptoms;
  double? depressionScore;
  int? lowEnergy;
  int? lowSelfEsteem;
  int? worseningDepression;
  double? sleepHours;
  double? socialMediaHours;
  int? eatingHabits;
  double? overeatingLevel;
  int? socialMediaWhileEating;
  double? nervousLevel;
  int? searchDepressionOnline;
  int? copingMethods;
  int? mentalHealthSupport;
  int? selfHarm;
  double? suicideAttempts;

  final Map<String, int> genderOptions = {"Male": 1, "Female": 0};
  final Map<String, int> educationOptions = {"High School": 0, "Bachelors": 1, "Masters": 2, "PhD": 3};
  final Map<String, int> employmentOptions = {"Unemployed": 0, "Part-time": 1, "Full-time": 2, "Student": 3, "Retired": 4};
  final Map<String, int> diagnosisOptions = {
    "None / Major Depressive": 0,
    "Persistent Depressive": 1,
    "Bipolar Disorder": 2,
    "Cyclothymic Disorder": 3,
    "Postpartum Depression": 4,
    "Premenstrual Dysphoric": 5,
    "Seasonal Affective": 6,
    "Atypical Depression": 7,
    "Psychotic Depression": 8,
    "Situational Depression": 9,
    "Melancholic Depression": 10,
    "Catatonic Depression": 11
  };
  final Map<String, int> symptomOptions = {
    "None / Sadness": 0,
    "Loss of Interest": 1,
    "Appetite Changes": 2,
    "Sleep Disturbances": 3,
    "Fatigue": 4,
    "Worthlessness": 5,
    "Difficulty Concentrating": 6,
    "Irritability": 7,
    "Physical Pain": 8,
    "Anxiety": 9,
    "Social Withdrawal": 10,
    "Hopelessness": 11,
    "Tearfulness": 12,
    "Guilt": 13,
    "Restlessness": 14
  };
  final Map<String, int> yesNoOptions = {"Yes": 1, "No": 0};
  final Map<String, int> eatingOptions = {"Irregularly": 0, "Regularly": 1};
  final Map<String, int> smWhileEatingOptions = {"Never": 0, "Rarely": 1, "Frequently": 2, "Always": 3};
  final Map<String, int> copingOptions = {
    "None / Exercise": 0,
    "Music": 1,
    "Reading": 2,
    "Writing": 3,
    "Friends / Family": 4,
    "Professional Help": 5,
    "Meditation": 6,
    "Hobbies": 7,
    "Art": 8,
    "Cooking": 9,
    "Travel": 10,
    "Sleeping": 11,
    "Healthy Eating": 12,
    "Volunteering": 13
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Advanced Mental Health AI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: SereneTheme.darkPink,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("General Information", style: SereneTheme.lightTheme.textTheme.headlineMedium),
              const SizedBox(height: 16),
              _buildMapDropdown("Gender", genderOptions, (v) => gender = v),
              _buildNumericField("Age", (v) => age = double.tryParse(v ?? "")),
              _buildMapDropdown("Education Level", educationOptions, (v) => educationLevel = v),
              _buildMapDropdown("Employment Status", employmentOptions, (v) => employmentStatus = v),
              
              const SizedBox(height: 32),
              Text("Assessment Details", style: SereneTheme.lightTheme.textTheme.headlineMedium),
              const SizedBox(height: 16),
              _buildMapDropdown("Prior Diagnosis", diagnosisOptions, (v) => depressionType = v),
              _buildMapDropdown("Primary Symptoms", symptomOptions, (v) => symptoms = v),
              _buildNumericField("Self-assessed Depression Score (0-30)", (v) => depressionScore = double.tryParse(v ?? "")),
              _buildMapDropdown("Low Energy?", yesNoOptions, (v) => lowEnergy = v),
              _buildMapDropdown("Low Self-Esteem?", yesNoOptions, (v) => lowSelfEsteem = v),
              _buildMapDropdown("Worsening Recently?", yesNoOptions, (v) => worseningDepression = v),
              
              const SizedBox(height: 32),
              Text("Lifestyle & Habits", style: SereneTheme.lightTheme.textTheme.headlineMedium),
              const SizedBox(height: 16),
              _buildNumericField("Average Sleep Hours", (v) => sleepHours = double.tryParse(v ?? "")),
              _buildNumericField("Social Media (Hours/Day)", (v) => socialMediaHours = double.tryParse(v ?? "")),
              _buildMapDropdown("Daily Eating Habits", eatingOptions, (v) => eatingHabits = v),
              _buildNumericField("Overeating Level (0-12)", (v) => overeatingLevel = double.tryParse(v ?? "")),
              _buildMapDropdown("Social Media While Eating?", smWhileEatingOptions, (v) => socialMediaWhileEating = v),
              _buildNumericField("Nervousness Level (0-10)", (v) => nervousLevel = double.tryParse(v ?? "")),
              
              const SizedBox(height: 32),
              Text("Support & Safety", style: SereneTheme.lightTheme.textTheme.headlineMedium),
              const SizedBox(height: 16),
              _buildMapDropdown("Search about Depression Online?", yesNoOptions, (v) => searchDepressionOnline = v),
              _buildMapDropdown("Coping Method", copingOptions, (v) => copingMethods = v),
              _buildMapDropdown("Access to Support?", yesNoOptions, (v) => mentalHealthSupport = v),
              _buildMapDropdown("Thoughts of Self-Harm?", yesNoOptions, (v) => selfHarm = v),
              _buildNumericField("Previous Suicide Attempts", (v) => suicideAttempts = double.tryParse(v ?? "")),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text("Submit Assessment"),
                ),
              ),
              const SizedBox(height: 40),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapDropdown(String label, Map<String, int> optionsMap, ValueChanged<int?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          labelText: label,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: optionsMap.entries
            .map((e) => DropdownMenuItem(value: e.value, child: Text(e.key)))
            .toList(),
        onChanged: onChanged,
        validator: (v) => v == null ? "Required" : null,
      ),
    );
  }

  Widget _buildNumericField(String label, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
      ),
    );
  }

 Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final answers = {
      "Gender": gender,
      "Age": age,
      "Education_Level": educationLevel,
      "Employment_Status": employmentStatus,
      "Depression_Type": depressionType,
      "Symptoms": symptoms,
      "Low_Energy": lowEnergy,
      "Low_SelfEsteem": lowSelfEsteem,
      "Search_Depression_Online": searchDepressionOnline,
      "Worsening_Depression": worseningDepression,
      "Your overeating level": overeatingLevel,
      "How many times you eat ": eatingHabits,
      "SocialMedia_Hours": socialMediaHours,
      "SocialMedia_WhileEating": socialMediaWhileEating,
      "Sleep_Hours": sleepHours,
      "Nervous_Level": nervousLevel,
      "Depression_Score": depressionScore,
      "Coping_Methods": copingMethods,
      "Self_Harm": selfHarm,
      "Mental_Health_Support": mentalHealthSupport,
      "Suicide_Attempts": suicideAttempts,
    };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final responseBody = await _callAdvancedPredict(widget.userId, answers);
      Navigator.pop(context);
      _showResultDialog(responseBody);
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<Map<String, dynamic>> _callAdvancedPredict(int user, Map<String, dynamic> answers) async {
    final response = await http.post(
      Uri.parse(Urlsss.advancedPredictUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user": user, ...answers}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed: ${response.body}");
    }
  }

  void _showResultDialog(Map<String, dynamic> result) {
    final bool isDepressed = result["is_depressed"] ?? false;
    final String type = result["potential_type"] ?? "None";
    final double prob = (result["probability"] ?? 0) * 100;
    final List suggestions = result["suggestions"] ?? [];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isDepressed ? "Depression Signs Detected" : "Low Risk Detected"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Confidence Score: ${prob.toStringAsFixed(1)}%"),
              if (isDepressed) Text("Potential Type: $type", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              const Divider(),
              const Text("Recovery Tips:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...suggestions.map((s) => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s["title"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ...(s["tips"] as List).map((t) => Text("• $t", style: const TextStyle(fontSize: 12))),
                  ],
                ),
              )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (isDepressed) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ChatBotScreen(userId: widget.userId)));
              } else {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen(userId: widget.userId)));
              }
            },
            child: Text(isDepressed ? "Talk to AI Assistant" : "Home"),
          ),
        ],
      ),
    );
  }
}
 