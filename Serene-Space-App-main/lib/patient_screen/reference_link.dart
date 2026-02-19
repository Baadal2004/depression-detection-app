import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:serene_space_project/patient_screen/home_screen.dart';
import 'package:serene_space_project/utils/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class PeriodsReferencesApp extends StatelessWidget {
  final List<Map<String, String>> references = [
    {
      'title': 'Menstruation — Wikipedia',
      'subtitle': 'General overview: cycle length, common features',
      'url': 'https://en.wikipedia.org/wiki/Menstruation',
    },
    {
      'title': 'Menstrual cycle — Wikipedia',
      'subtitle': 'Phases, hormones, ovulation',
      'url': 'https://en.wikipedia.org/wiki/Menstrual_cycle',
    },
    {
      'title': 'Menstrual Cycle: Overview & Phases — Cleveland Clinic',
      'subtitle': 'Clinical overview: duration, symptoms',
      'url':
          'https://my.clevelandclinic.org/health/articles/10132-menstrual-cycle',
    },
    {
      'title': 'Menstruation (periods) — MedlinePlus',
      'subtitle': 'Health-oriented basics and symptoms',
      'url': 'https://medlineplus.gov/menstruation.html',
    },
    {
      'title': 'Periods / Menstruation — Healthdirect',
      'subtitle': 'What happens, typical duration, when to seek help',
      'url': 'https://www.healthdirect.gov.au/menstruation',
    },
    {
      'title': 'Physiology, Menstrual Cycle — NCBI / StatPearls',
      'subtitle': 'Medical detail on hormones and coordination',
      'url': 'https://www.ncbi.nlm.nih.gov/books/NBK500020/',
    },
  ];

  PeriodsReferencesApp({super.key,required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {
    int userId = this.userId;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with gradient and rounded bottom
            Container(
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
                          'Trusted Resources',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Curated links for your mental well-being',
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
            ),
            SizedBox(height: 18),

            // Search bar
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
            //   child: Material(
            //     elevation: 2,
            //     borderRadius: BorderRadius.circular(14),
            //     child: Container(
            //       padding: EdgeInsets.symmetric(horizontal: 12),
            //       height: 48,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(14),
            //       ),
            //       child: Row(
            //         children: [
            //           Icon(Icons.search, color: Colors.grey[600]),
            //           SizedBox(width: 10),
            //           Expanded(
            //             child: TextField(
            //               decoration: InputDecoration(
            //                 border: InputBorder.none,
            //                 hintText: 'Search references (try "NCBI" or "Cleveland")',
            //               ),
            //               onChanged: (q) {
            //                 // Intentionally empty for this demo. Hook up with state for live search.
            //               },
            //             ),
            //           ),
            //           PopupMenuButton<String>(
            //             itemBuilder: (_) => [
            //               PopupMenuItem(value: 'all', child: Text('All')),
            //               PopupMenuItem(value: 'medical', child: Text('Medical')),
            //               PopupMenuItem(value: 'general', child: Text('General')),
            //             ],
            //             icon: Icon(Icons.filter_list, color: Colors.grey[600]),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 18),

            // List of references
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: ListView.builder(
                  itemCount: references.length,
                  padding: EdgeInsets.only(bottom: 28),
                  itemBuilder: (context, index) {
                    final ref = references[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: GlassCard(
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: CircleAvatar(
                            radius: 26,
                            // ignore: deprecated_member_use
                            backgroundColor: Colors.white.withOpacity(0.9),
                            child: Icon(Icons.link, color: Colors.pinkAccent),
                          ),
                          title: Text(
                            ref['title']!,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(ref['subtitle']!),
                          trailing: IconButton(
                            icon: Icon(Icons.open_in_new),
                            onPressed: () => _launchURL(ref['url']!),
                          ),
                          onTap: () => _launchURL(ref['url']!),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Example: open a curated reading list or export
      //   },
      //   label: Text('Export List'),
      //   icon: Icon(Icons.download),
      // ),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

// GlassCard: lightweight glassmorphism card using BackdropFilter
class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.65),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
            // ignore: deprecated_member_use
            border: Border.all(color: Colors.white.withOpacity(0.6)),
          ),
          child: child,
        ),
      ),
    );
  }
}
