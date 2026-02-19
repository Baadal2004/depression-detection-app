import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:serene_space_project/authentication/patient/login_screen/login_view_page.dart';
import 'package:serene_space_project/patient_screen/articles_screen.dart';
import 'package:serene_space_project/patient_screen/do_donts.dart';
import 'package:serene_space_project/patient_screen/pcod_prediction/input_condition_datas.dart/input_condition_view.dart';
import 'package:serene_space_project/patient_screen/reference_link.dart';
import 'package:serene_space_project/patient_screen/videos/videos.dart';
import 'package:serene_space_project/patient_screen/view_books/view_book.dart';
import 'package:serene_space_project/patient_screen/view_my_hosbooking.dart';
import 'package:serene_space_project/screens/chatbot/chatbot.dart';
import 'package:serene_space_project/screens/menstrual_track/input_cycle/input_cycle_view.dart';
import 'package:serene_space_project/screens/emotion_detection_view.dart';
import 'package:serene_space_project/utils/app_theme.dart';
import 'package:typewritertext/typewritertext.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userId, this.name = ''});
  final int userId;
  final String name;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  String title = "Serene Space";
  String? name;
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  int? userId;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
    userId = widget.userId;
    
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout Alert"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog first
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(userId: userId!),
                ),
              ); // Navigate to login (Yes)// Close dialog (No)
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog first
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              ); // Navigate to login (Yes)
            },
            child: const Text(
              "Yes, Logout",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget quickModules() {
    final modules = [
      {'icon': Icons.book_rounded, 'label': 'Books', 'color': Color(0xFFFCE4EC)},
      {'icon': Icons.video_library_rounded, 'label': 'Videos', 'color': Color(0xFFF3E5F5)},
      {'icon': Icons.link_rounded, 'label': 'Links', 'color': Color(0xFFE8F5E9)},
      {'icon': Icons.article_rounded, 'label': 'Articles', 'color': Color(0xFFE3F2FD)},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.1,
        ),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final module = modules[index];
          return GestureDetector(
            onTap: () {
              if (module['label'] == 'Books') {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => BookListPage()));
              } else if (module['label'] == 'Videos') {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PregnancyVideoScreen()));
              } else if (module['label'] == 'Links') {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PeriodsReferencesApp(userId: userId!)));
              } else if (module['label'] == 'Articles') {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PeriodsArticlesApp(userId: userId!)));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: SereneTheme.primaryPink.withOpacity(0.08),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
                border: Border.all(color: SereneTheme.lightPink, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: (module['color'] as Color).withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      module['icon'] as IconData,
                      size: 32,
                      color: SereneTheme.darkPink,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '${module['label']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: SereneTheme.darkPink.withOpacity(0.8),
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
  Widget _toolCard({
    required double h,
    required double w,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Center(
      child: Container(
        height: h * 0.32,
        width: w * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: SereneTheme.primaryPink.withOpacity(0.12),
              blurRadius: 25,
              offset: const Offset(0, 12),
            ),
          ],
          border: Border.all(color: SereneTheme.lightPink, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              Positioned(
                top: -20,
                right: -20,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: SereneTheme.lightPink.withOpacity(0.4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: SereneTheme.darkPink,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SliderDrawer(
          key: _sliderDrawerKey,
          sliderOpenSize: 300.0,
          slideDirection: SlideDirection.leftToRight,
          sliderBoxShadow: SliderBoxShadow(
            blurRadius: 25,
            spreadRadius: 5,
            color: const Color.fromARGB(255, 94, 135, 168),
          ),
          slider: _buildDrawer(),
          appBar: SliderAppBar(
            config: SliderAppBarConfig(
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26, // Larger for elderly
                  fontWeight: FontWeight.w800,
                  color: SereneTheme.darkPink,
                ),
              ),
              trailing: Image.asset('assets/images/mental-health-logo.jpg'),
            ),
          ),
          child: SafeArea(
            child: Scaffold(
              extendBody: false,

              //     floatingActionButton: FloatingActionButton(
              //       onPressed: () {
              //         if (userId != null) {
              //             Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return ChatBotScreen(userId: userId!,);
              //     },
              //   ),
              // );
              //           // Navigator.of(context).push(
              //           //   MaterialPageRoute(
              //           //     builder: (context) {
              //           //     //  return ChatScreen(userId: userId!);
              //           //     },
              //           //   ),
              //           // );
              //         } else {
              //           // Optional: handle error or show a toast/snackbar
              //         }
              //       },
              //       child: Icon(Icons.chat),
              //     ),
              bottomNavigationBar: CircleNavBar(
                activeIcons: const [
                  Icon(Icons.home, color: SereneTheme.darkPink, size: 30),
                  Icon(Icons.logout, color: SereneTheme.darkPink, size: 30),
                ],
                inactiveIcons: const [
                  Text("Home", style: TextStyle(fontWeight: FontWeight.bold, color: SereneTheme.darkPink)),
                  Text("Logout", style: TextStyle(fontWeight: FontWeight.bold, color: SereneTheme.darkPink))
                ],
                color: Colors.white,
                height: 70, // Slightly taller
                circleWidth: 65,
                activeIndex: tabIndex,
                onTap: (index) {
                  tabIndex = index;
                  pageController.jumpToPage(tabIndex);
                  if (index == 1) {
                    _showLogoutDialog(context);
                  }
                },
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                cornerRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                shadowColor: SereneTheme.primaryPink.withOpacity(0.3),
                elevation: 10,
              ),
              body: PageView(
                controller: pageController,
                onPageChanged: (v) {
                  tabIndex = v;
                },
                children: [
                  // Home tab page with Quick Modules
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 18),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Featured Tools",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 24, // Larger for elderly
                                color: SereneTheme.darkPink,
                              ),
                            ),
                        ),
                        const SizedBox(height: 10),
                        quickModules(),
                        const SizedBox(height: 25),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                ),
                                child: Row(
                                  children: [
                                    _toolCard(
                                      h: h, w: w,
                                      title: 'Understand ADHD Better With Smart AI',
                                      description: 'Our AI analyzes your inputs to help detect possible ADHD symptoms and gives you smart guidance for better mental clarity.',
                                      buttonText: '🎯 ADHD Check',
                                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PeriodInputScreen(userId: userId!, name: widget.name))),
                                    ),
                                    const SizedBox(width: 18),
                                    _toolCard(
                                      h: h, w: w,
                                      title: 'Check Your Depression Levels',
                                      description: 'Fill the fields about your mood, stress, and sleep. Our AI will analyze your patterns and help detect anxiety or depression early.',
                                      buttonText: '😔 Depression AI',
                                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HealthProfileScreen(userId: userId!))),
                                    ),
                                    const SizedBox(width: 18),
                                    _toolCard(
                                      h: h, w: w,
                                      title: 'Smart Cycle Tracking AI',
                                      description: 'Ask anything about mental health or PCOD — our smart AI ChatBot gives instant, personalized answers to support you.',
                                      buttonText: '🤖 ChatBot',
                                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatBotScreen(userId: userId!))),
                                    ),
                                    const SizedBox(width: 18),
                                    _toolCard(
                                      h: h, w: w,
                                      title: 'Real-time Emotion Detection',
                                      description: 'Understand your mood instantly. Use our AI camera to detect your current emotion and track your mental well-being.',
                                      buttonText: '📸 Emotion AI',
                                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EmotionDetectionScreen())),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                  Container(color: Colors.transparent),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Elegant Drawer Header
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 30, left: 24, right: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [SereneTheme.lightPink, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: SereneTheme.primaryPink, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundColor: SereneTheme.lightPink,
                    child: Icon(Icons.person_rounded, size: 40, color: SereneTheme.darkPink),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name.isNotEmpty ? widget.name : "Serene User",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: SereneTheme.darkPink,
                        ),
                      ),
                      const Text(
                        "Inner Peace, Outer Calm",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(indent: 20, endIndent: 20, thickness: 1, color: SereneTheme.lightPink),
          
          // Drawer Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                _drawerTile(
                  icon: Icons.home_rounded,
                  title: "Home Dashboard",
                  onTap: () => _sliderDrawerKey.currentState!.closeSlider(),
                ),
                _drawerTile(
                  icon: Icons.calendar_month_rounded,
                  title: "My Appointments",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HosDoctorAppointmentsPages(userId: userId!)),
                  ),
                ),
                _drawerTile(
                  icon: Icons.checklist_rounded,
                  title: "Health Do's & Don'ts",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PeriodsDoDontsApp(userId: userId!)),
                  ),
                ),
                _drawerTile(
                  icon: Icons.help_outline_rounded,
                  title: "Support Center",
                  onTap: () {
                    // Placeholder for support
                  },
                ),
              ],
            ),
          ),
          
          // Logout at bottom
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextButton.icon(
              onPressed: () => _showLogoutDialog(context),
              icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
              label: const Text(
                "Sign Out",
                style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.red.withOpacity(0.05),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: SereneTheme.primaryPink),
        title: Text(
          title,
          style: const TextStyle(
            color: SereneTheme.textMain,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.black26),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: onTap,
        hoverColor: SereneTheme.lightPink,
      ),
    );
  }
}
