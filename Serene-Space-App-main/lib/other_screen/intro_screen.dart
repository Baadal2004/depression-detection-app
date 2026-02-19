import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:serene_space_project/other_screen/role_wise.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  void _onIntroEnd(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RoleSelectionScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 166, 177, 240),
      body: Stack(
        children: [
          IntroductionScreen(
            //bodyPadding: EdgeInsets.only(top: 50.0),
            pages: [
              PageViewModel(
                title: "ADHD Screening",
                body:
                    "Enter your symptoms and daily challenges to get a smart assessment. Receive helpful insights and personalized remedies to improve focus and productivity.",
                image: Image.asset("assets/images/adhd.jpg", height: 175.0),
              ),
          
              PageViewModel(
                title: "Anxiety Check",
                body:
                    "Share how you’ve been feeling lately and get an instant mental wellness prediction. If high stress or anxiety is detected, you can easily book an appointment with a specialist.",
                image: Image.asset(
                  "assets/images/stress.jpg",
                  height: 175.0,
                ),
              ),
              PageViewModel(
                title: "Live Emotion Detection",
                body:
                    "Use your camera to scan facial expressions in real time and detect emotions like happiness, sadness, fear, or stress to better understand your mental state.",
                image: Image.asset(
                  "assets/images/Emotion-recognition.jpg",
                  height: 175.0,
                ),
              ),
            ],
            showSkipButton: true,
            //showDoneButton: true,
            // back: const Text("Back", style: TextStyle(fontWeight: FontWeight.w600)),
            skip: const Text(
              "Skip",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 19, 30, 90),
              ),
            ),
            next: const Text(
              "Next",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 19, 30, 90),
              ),
            ),
            done: const Text(
              "Done",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            onDone: () => _onIntroEnd(context),
            dotsDecorator: DotsDecorator(
              size: const Size(10.0, 10.0),
              activeColor: Theme.of(context).colorScheme.secondary,
              color: const Color.fromARGB(255, 12, 22, 82),
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
