import 'package:animated_input_border/animated_input_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serene_space_project/authentication/patient/login_screen/bloc/login_screen_bloc.dart';
import 'package:serene_space_project/authentication/patient/registration_screen/registration_page_view.dart';
import 'package:serene_space_project/other_screen/role_wise.dart';
import 'package:serene_space_project/patient_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:serene_space_project/utils/app_theme.dart';
import 'package:serene_space_project/hospital_doctor_screen/hospital_home_screen/hospital_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  late AnimationController _animationController;
  bool isloading = false;
  final String _selectedUserType = 'user';
  int? userId;
  String? name;
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();
  }

  Future<void> loginState() async {
  //  print(123);
    FocusScope.of(context).unfocus();
    setState(() {
      isloading = true;
    });
    String emplId = emailController.text.trim();
    String emplPass = passController.text.trim();

   // print('after validation');

    if (emplId.isEmpty || emplPass.isEmpty) {
      showError("Please enter all details");
      setState(() => isloading = false);
      return;
    }
    context.read<LoginScreenBloc>().add(
      LoginScreenEvent.userLogin(
        role: _selectedUserType,
        email: emplId,
        password: emplPass,
      ),
    );
  }

  Future<void> storeUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', userId);
   // print('User ID stored: $userId');
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('id');
   // print("Retrieved User ID: $userId");
    return userId;
  }

  Future<void> storeUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    //print('User name stored: $name');
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    //print("Retrieved User name: $name");
    return name;
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  Widget _buildTextField(
    String label, {
    required TextEditingController controller,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: SereneTheme.primaryPink.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: label.toLowerCase().contains('password'),
        style: const TextStyle(fontWeight: FontWeight.w600, color: SereneTheme.darkPink),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.pink.shade200, fontWeight: FontWeight.w500),
          prefixIcon: Icon(
            label.toLowerCase().contains('email') ? Icons.email_rounded : Icons.lock_rounded,
            color: SereneTheme.primaryPink.withOpacity(0.6),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: SereneTheme.primaryPink.withOpacity(0.1), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: SereneTheme.primaryPink, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 80,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.support_agent,
                  color: SereneTheme.primaryPink,
                  size: 32,
                ),
                Text(
                  "Serene",
                  style: TextStyle(
                    color: SereneTheme.darkPink,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => RoleSelectionScreen()),
              ),
              icon: const Icon(
                Icons.rotate_left_outlined,
                color: SereneTheme.darkPink,
                size: 35,
              ),
            ),
          ],
        ),

        body: BlocConsumer<LoginScreenBloc, LoginScreenState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () {
                setState(() {
                  isloading = true;
                });
              },
              success: (response) async {
                await storeUserId(response.userId);
                userId = await getUserId();
                await storeUserName(response.name);
                name = await getUserName();
                setState(() {
                  isloading = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("User login successful"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  if (response.role.toLowerCase().contains('doctor')) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HospaitalDocHomeScreen(doctorId: userId!),
                      ),
                    );
                  } else {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return HomeScreen(userId: userId!);
                        },
                      ),
                    );
                  }
                });
              },
              error: (error) {
                setState(() {
                  isloading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error: $error"),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
          },
          builder: (context, state) => SingleChildScrollView(
            child: SizedBox(
              height: h,
              width: w,

              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     opacity: 0.4,
              //     fit: BoxFit.fill,
              //     image: AssetImage('assets/images/loogo.jpeg'),
              //   ),
              // ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      SereneTheme.lightPink,
                      Colors.white,
                      SereneTheme.lightPink.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 24, right: 24),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Logo Container with glass-like effect
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: SereneTheme.primaryPink.withOpacity(0.2),
                                blurRadius: 30,
                                spreadRadius: 5,
                                offset: const Offset(0, 15),
                              ),
                            ],
                            border: Border.all(
                              color: SereneTheme.primaryPink.withOpacity(0.3),
                              width: 3,
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/images4.jpg",
                              width: h * 0.22,
                              height: h * 0.22,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ).animate().fadeIn(duration: 800.ms).scale(curve: Curves.elasticOut),
                        
                        const SizedBox(height: 30),
                        
                        // Welcome Text
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: SereneTheme.darkPink,
                            letterSpacing: 1.2,
                          ),
                        ).animate().slideY(begin: 0.3, duration: 600.ms).fadeIn(),
                        
                        const SizedBox(height: 10),
                        
                        const Text(
                          "Let's get you back to your serene space",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ).animate().slideY(begin: 0.5, duration: 700.ms).fadeIn(),

                        const SizedBox(height: 40),
                        
                        // Action Form
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) => Form(
                            key: _fromKey,
                            child: Column(
                              children: [
                                _buildTextField(
                                  "Email Address",
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "We need your email to start!";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  "Password",
                                  controller: passController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your password";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ).animate().fadeIn(delay: 400.ms),

                        const SizedBox(height: 40),
                        
                        // Login Button
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [SereneTheme.accentPink, SereneTheme.primaryPink],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: SereneTheme.primaryPink.withOpacity(0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              fixedSize: Size(w * 0.85, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: isloading ? null : loginState,
                            child: isloading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                                    "CONTINUE",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                          ),
                        ).animate().scale(delay: 600.ms, duration: 400.ms),
                        
                        const SizedBox(height: 25),
                        
                        // Signup Link
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationPage(),
                              ),
                            );
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'New here? ',
                                    style: TextStyle(color: Colors.black45, fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: 'Join Serene Space',
                                    style: TextStyle(
                                      color: SereneTheme.darkPink,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ).animate().fadeIn(delay: 800.ms),
                        
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    //);
  }
}
