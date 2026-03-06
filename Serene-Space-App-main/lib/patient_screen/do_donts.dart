// Beautiful & elegant Flutter UI for:
// ✔ Do’s & Don’ts about ADHD & Depression
// ✔ Wellness Tools (Journaling, White Noise, etc.)
// Add: url_launcher: ^6.1.7 to pubspec.yaml

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:serene_space_project/patient_screen/home_screen.dart';

class MentalHealthWellnessApp extends StatelessWidget {
  final List<Map<String, String>> dos = [
    {
      'title': 'Practice Mindfulness',
      'desc': 'Spend 10 minutes daily in meditation to calm your mind.',
    },
    {
      'title': 'Maintain a Routine',
      'desc': 'A consistent schedule helps manage ADHD symptoms effectively.',
    },
    {
      'title': 'Regular Exercise',
      'desc': 'Physical activity releases endorphins that improve mood.',
    },
    {
      'title': 'Healthy Sleep Hygiene',
      'desc': 'Stick to a regular sleep schedule for better mental clarity.',
    },
  ];

  final List<Map<String, String>> donts = [
    {
      'title': 'Do Not Isolate Yourself',
      'desc': 'Reach out to friends or family when you feel low.',
    },
    {
      'title': 'Don\'t Skip Medication',
      'desc': 'Always follow your prescribed treatment plan consistently.',
    },
    {
      'title': 'Avoid Excessive Caffeine',
      'desc': 'Too much caffeine can increase anxiety and restlessness.',
    },
    {
      'title': 'Avoid Negative Self-Talk',
      'desc': 'Be kind to yourself; mental health recovery takes time.',
    },
  ];

  final List<Map<String, String>> products = [
    {
      'title': 'Journaling Apps',
      'desc': 'Track your moods and thoughts daily.',
      'icon': '📝',
    },
    {
      'title': 'White Noise Machine',
      'desc': 'Helps focus by blocking distracting background noises.',
      'icon': '🔊',
    },
    {
      'title': 'Stress Relief Balls',
      'desc': 'Great for managing restlessness and anxiety.',
      'icon': '🎾',
    },
    {
      'title': 'Weighted Blankets',
      'desc': 'Provides a sense of security and improves sleep quality.',
      'icon': '🛌',
    },
  ];

  MentalHealthWellnessApp({super.key, required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(context),
            SizedBox(height: 20),

            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                children: [
                  sectionTitle('Mental Health Do’s'),
                  SizedBox(height: 10),
                  ...dos.map(
                    (d) => GlassCard(
                      child: buildTile(
                        d['title']!,
                        d['desc']!,
                        Icons.check_circle,
                        Colors.green,
                      ),
                    ),
                  ),

                  SizedBox(height: 25),
                  sectionTitle('Mental Health Don’ts'),
                  SizedBox(height: 10),
                  ...donts.map(
                    (d) => GlassCard(
                      child: buildTile(
                        d['title']!,
                        d['desc']!,
                        Icons.cancel,
                        Colors.redAccent,
                      ),
                    ),
                  ),

                  SizedBox(height: 25),
                  sectionTitle('Supportive Tools'),
                  SizedBox(height: 10),
                  ...products.map((p) => GlassCard(child: productTile(p))),

                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFA3C3), Color(0xFFFF5F9C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: Colors.white.withOpacity(0.25),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded, size: 36, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mental Health Guide',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'ADHD & Depression Support',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    );
  }

  ListTile buildTile(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: CircleAvatar(
        // ignore: deprecated_member_use
        backgroundColor: color.withOpacity(0.15),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle: Text(subtitle),
    );
  }

  ListTile productTile(Map<String, String> p) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      leading: CircleAvatar(
        radius: 26,
        // ignore: deprecated_member_use
        backgroundColor: Colors.white.withOpacity(0.9),
        child: Text(p['icon']!, style: TextStyle(fontSize: 22)),
      ),
      title: Text(p['title']!, style: TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(p['desc']!),
    );
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.65),
              borderRadius: BorderRadius.circular(16),
              // ignore: deprecated_member_use
              border: Border.all(color: Colors.white.withOpacity(0.6)),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
