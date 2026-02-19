import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:serene_space_project/other_screen/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    //required this.userId
  });
  //final int userId;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? userId;

  @override
  void initState() {
    super.initState();
    //userId = widget.userId;
    displayImage();
  }

  void displayImage() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return IntroPage(
              // userId: widget.userId
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 71, 1, 80),
              Color.fromARGB(255, 248, 246, 248),
              Color.fromARGB(255, 248, 246, 248),

              Color.fromARGB(255, 71, 1, 80),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.white, Colors.purple.shade50],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
              border: Border.all(color: Colors.purple.shade300, width: 2),
            ),
            padding: const EdgeInsets.all(8),
            child: ClipOval(
              child: Image.asset(
                "assets/images/mental-health-logo.jpg",
                width: h * 0.25,
                height: h * 0.25,
                fit: BoxFit.cover,
              ),
            ).animate().scale(duration: 3.5.seconds, curve: Curves.easeOutBack),
          ),
        ),
      ),
    );
  }
}
