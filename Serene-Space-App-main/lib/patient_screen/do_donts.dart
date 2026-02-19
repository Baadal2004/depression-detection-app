// Beautiful & elegant Flutter UI for:
// ✔ Do’s & Don’ts about Periods
// ✔ Period Products (Pads, Tampons, Cups, Pain Relief, etc.)
// Add: url_launcher: ^6.1.7 to pubspec.yaml

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:serene_space_project/patient_screen/home_screen.dart';

class PeriodsDoDontsApp extends StatelessWidget {
  final List<Map<String, String>> dos = [
    {
      'title': 'Stay Hydrated',
      'desc': 'Drink plenty of water to reduce bloating and fatigue.',
    },
    {
      'title': 'Use Heat Pads',
      'desc': 'A warm compress helps relieve stomach and back pain.',
    },
    {
      'title': 'Eat Iron-rich Foods',
      'desc': 'Include spinach, beetroot, dates, and nuts to maintain energy.',
    },
    {
      'title': 'Take Proper Rest',
      'desc': 'Your body needs extra rest during menstruation.',
    },
  ];

  final List<Map<String, String>> donts = [
    {
      'title': 'Avoid Junk Food',
      'desc': 'Oily and spicy foods can worsen cramps and bloating.',
    },
    {
      'title': 'Do Not Skip Meals',
      'desc': 'Skipping food may cause weakness and dizziness.',
    },
    {
      'title': 'Avoid Heavy Workouts',
      'desc': 'Mild stretching is fine; heavy lifting increases discomfort.',
    },
    {
      'title': 'Avoid Excess Sugar',
      'desc': 'Sugar can trigger mood swings and acne flare-ups.',
    },
  ];

  final List<Map<String, String>> products = [
    {
      'title': 'Sanitary Pads',
      'desc': 'Most commonly used; comfortable and safe for beginners.',
      'icon': '🩸',
    },
    {
      'title': 'Tampons',
      'desc': 'Inserted product; comfortable for sports and swimming.',
      'icon': '✨',
    },
    {
      'title': 'Menstrual Cups',
      'desc': 'Eco‑friendly, reusable, and lasts up to 10 years.',
      'icon': '🌸',
    },
    {
      'title': 'Period Panties',
      'desc': 'Leak-proof underwear suitable for night use.',
      'icon': '🩲',
    },
    {
      'title': 'Pain Relief Roll-ons',
      'desc': 'Useful to relieve cramps naturally.',
      'icon': '🌿',
    },
  ];

  PeriodsDoDontsApp({super.key,required this.userId});
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
                  sectionTitle('Do’s During Periods'),
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
                  sectionTitle('Don’ts During Periods'),
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
                  sectionTitle('Period Products'),
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
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFA3C3), Color(0xFFFF5F9C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.pink.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            // ignore: deprecated_member_use
            backgroundColor: Colors.white.withOpacity(0.25),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen(userId: userId);
                    },
                  ),
                );
              },
              icon: Icon(Icons.favorite, size: 36, color: Colors.white),
            ),
            //
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Periods Wellness Guide',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              // Text('Know what to do, avoid & best products',
              //     style: TextStyle(color: Colors.white.withOpacity(0.9))),
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
