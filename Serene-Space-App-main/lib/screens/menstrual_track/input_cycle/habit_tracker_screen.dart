import 'package:flutter/material.dart';
import 'package:serene_space_project/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HabitTrackerScreen extends StatefulWidget {
  final bool isAdhdDetected; // To show relevant suggestions
  final int userId;

  const HabitTrackerScreen({
    super.key,
    required this.isAdhdDetected,
    required this.userId,
  });

  @override
  State<HabitTrackerScreen> createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen> {
  List<Map<String, dynamic>> habits = [];
  final TextEditingController _habitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  // Load habits from SharedPreferences
  Future<void> _loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final String? habitsJson = prefs.getString('habits_${widget.userId}');
    if (habitsJson != null) {
      setState(() {
        habits = List<Map<String, dynamic>>.from(json.decode(habitsJson));
      });
    } else {
      // Default habits based on ADHD detection
      if (widget.isAdhdDetected) {
        habits = [
          {'title': 'Meditate for 10 mins', 'isCompleted': false},
          {'title': 'Drink 8 glasses of water', 'isCompleted': false},
          {'title': 'No screen time 1h before bed', 'isCompleted': false},
        ];
      } else {
        habits = [
          {'title': 'Read for 15 mins', 'isCompleted': false},
          {'title': 'Go for a walk', 'isCompleted': false},
        ];
      }
      _saveHabits();
    }
  }

  // Save habits to SharedPreferences
  Future<void> _saveHabits() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('habits_${widget.userId}', json.encode(habits));
  }

  // Add a new habit
  void _addHabit() {
    if (_habitController.text.isNotEmpty) {
      setState(() {
        habits.add({'title': _habitController.text, 'isCompleted': false});
        _habitController.clear();
      });
      _saveHabits();
      Navigator.pop(context);
    }
  }

  // Toggle habit completion
  void _toggleHabit(int index) {
    setState(() {
      habits[index]['isCompleted'] = !habits[index]['isCompleted'];
    });
    _saveHabits();
  }

  // Delete a habit
  void _deleteHabit(int index) {
    setState(() {
      habits.removeAt(index);
    });
    _saveHabits();
  }

  // Show "Add Habit" dialog
  void _showAddHabitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Habit"),
          content: TextField(
            controller: _habitController,
            decoration: const InputDecoration(hintText: "Enter habit name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: _addHabit,
              child: const Text("Add"),
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
        title: const Text(
          "Habit Tracker & Suggestions",
          style: TextStyle(color: SereneTheme.darkPink),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: SereneTheme.darkPink),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Smart Suggestions Section
            Text(
              "Smart Suggestions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: SereneTheme.darkPink,
              ),
            ),
            const SizedBox(height: 10),
            _buildSuggestions(),

            const SizedBox(height: 30),

            // Habit Tracker Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Daily Habits",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: SereneTheme.darkPink,
                  ),
                ),
                IconButton(
                  onPressed: _showAddHabitDialog,
                  icon: const Icon(Icons.add_circle, color: SereneTheme.primaryPink, size: 30),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildHabitList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    final suggestions = widget.isAdhdDetected
        ? [
            {
              'title': 'Break Tasks Down',
              'desc': 'Split large tasks into smaller, manageable chunks to avoid overwhelm.'
            },
            {
              'title': 'Use a Timer',
              'desc': 'Work in short bursts (e.g., 25 mins) followed by a short break.'
            },
            {
              'title': 'Minimize Distractions',
              'desc': 'Keep your workspace tidy and turn off non-essential notifications.'
            },
            {
              'title': 'Regular Exercise',
              'desc': 'Physical activity boosts dopamine, effectively helping focus.'
            },
          ]
        : [
            {
              'title': 'Maintain Routine',
              'desc': 'Consistency helps in maintaining good mental health.'
            },
            {
              'title': 'Stay Hydrated',
              'desc': 'Drinking water improves cognitive function and energy levels.'
            },
            {
              'title': 'Mindfulness',
              'desc': 'Practice gratitude or meditation to stay grounded.'
            },
          ];

    return Column(
      children: suggestions.map((s) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: const Icon(Icons.lightbulb, color: Colors.amber),
            title: Text(
              s['title']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(s['desc']!),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHabitList() {
    if (habits.isEmpty) {
      return const Center(child: Text("No habits added yet."));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final habit = habits[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: CheckboxListTile(
            activeColor: SereneTheme.primaryPink,
            title: Text(
              habit['title'],
              style: TextStyle(
                decoration: habit['isCompleted']
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            value: habit['isCompleted'],
            onChanged: (val) => _toggleHabit(index),
            secondary: IconButton(
              icon: const Icon(Icons.delete, color: Colors.grey),
              onPressed: () => _deleteHabit(index),
            ),
          ),
        );
      },
    );
  }
}
