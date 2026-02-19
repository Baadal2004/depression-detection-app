import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:serene_space_project/authentication/patient/login_screen/login_view_page.dart';
import 'package:serene_space_project/other_screen/doctor_clinic_screen.dart';
import 'package:serene_space_project/utils/app_theme.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _renderBg() {
    return Container(
      color: Colors.white,
      // decoration:
      // BoxDecoration(
      //   // color: const Color(0xFFFFFFFF)
      //   // Image.asset('assets/images/61804.jpg', fit: BoxFit.cover),
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/61802.jpg'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
    );
  }

  _renderAppBar(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: AppBar(elevation: 0.0, backgroundColor: Color(0x00FFFFFF)),
    );
  }

  _renderContent(context) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
      color: Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        side: CardSide.FRONT,
        speed: 1000,
        onFlipDone: (status) {
          //print(status);
        },
        front: Container(
          decoration: BoxDecoration(
            color: SereneTheme.lightPink,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: SereneTheme.primaryPink.withOpacity(0.3), width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset(
                  'assets/images/Capture.JPG',
                  
                  height: 200,
                  width: 200,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.person, color: Colors.white),
                label: const Text(
                  'PATIENT',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    Text(
                      'Click here to flip back ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '----->',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        back: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: SereneTheme.primaryPink.withOpacity(0.3), width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset(
                  'assets/images/WhatsApp Image 2025-08-08 at 16.13.52_da8432b7.jpg',
                  height: 200,
                  width: 200,
                  // height: 200,
                  // width: 200,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return FindDoctorPage();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.medical_services, color: Colors.white),
                label: const Text(
                  'DOCTOR',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    Text(
                      'Click here to flip front ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '<-----',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: SereneTheme.primaryPink.withOpacity(0.1),
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/images/medical-symbol.png',
                  height: 35,
                  width: 35,
                ),
              ),
            ),
          ),
          title: const Text(
            'Select Your Role',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: SereneTheme.darkPink,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),

        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _renderBg(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _renderAppBar(context),
                Expanded(flex: 4, child: _renderContent(context)),
                Expanded(flex: 1, child: Container()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
