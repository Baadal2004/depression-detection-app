// Flutter beautiful UI for Articles + Important Documents on Periods
// Add in pubspec.yaml: url_launcher: ^6.1.7

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:serene_space_project/patient_screen/home_screen.dart';
import 'package:serene_space_project/utils/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class PeriodsArticlesApp extends StatelessWidget {
  final List<Map<String, String>> articles = [
    {
      'title': 'Understanding Menstruation',
      'desc': 'Learn what periods are, symptoms, myths, and health tips.',
      'url': 'https://en.wikipedia.org/wiki/Menstruation',
    },
    {
      'title': 'Menstrual Cycle Explained',
      'desc': 'Deep dive into ovulation, phases, hormones & cycle patterns.',
      'url': 'https://en.wikipedia.org/wiki/Menstrual_cycle',
    },
    {
      'title': 'Clinical Guide on Menstrual Health',
      'desc': 'Cleveland Clinic overview on duration, symptoms, treatment.',
      'url':
          'https://my.clevelandclinic.org/health/articles/10132-menstrual-cycle',
    },
  ];

  final List<Map<String, String>> documents = [
    {
      'title': 'Menstrual Hygiene Guidelines PDF',
      'desc': 'Official menstrual hygiene document by health authorities.',
      'url': 'https://www.ncbi.nlm.nih.gov/books/NBK500020/',
    },
    {
      'title': 'Adolescent Health & Period Care',
      'desc': 'Important WHO PDF on menstrual education and awareness.',
      'url': 'https://medlineplus.gov/menstruation.html',
    },
    {
      'title': 'Understanding PCOS & Period Irregularities',
      'desc': 'Medical documentation on PCOS impact on menstruation.',
      'url': 'https://www.healthdirect.gov.au/menstruation',
    },
  ];

  PeriodsArticlesApp({super.key,required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(context),
            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Articles',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  ...articles.map(
                    (a) => GlassCard(
                      child: buildListTile(a['title']!, a['desc']!, a['url']!),
                    ),
                  ),

                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Text(
                      'Important Documents',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),

                  ...documents.map(
                    (d) => GlassCard(
                      child: buildListTile(d['title']!, d['desc']!, d['url']!),
                    ),
                  ),

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
      padding: const EdgeInsets.only(top: 25, bottom: 25, left: 16, right: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [SereneTheme.accentPink, SereneTheme.primaryPink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: SereneTheme.primaryPink.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          // Modern Back Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22, color: Colors.white),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Knowledge Hub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Articles • Research • Official Guides',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(String title, String subtitle, String url) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: CircleAvatar(
        radius: 26,
        // ignore: deprecated_member_use
        backgroundColor: Colors.white.withOpacity(0.9),
        child: Icon(Icons.description_outlined, color: Colors.pink),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.open_in_new),
      onTap: () =>
          launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
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
