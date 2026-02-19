// ignore_for_file: avoid_print


import 'package:flutter/material.dart';
import 'package:animated_input_border/animated_input_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:serene_space_project/utils/app_theme.dart';
import 'package:serene_space_project/authentication/patient/login_screen/login_view_page.dart';
import 'package:serene_space_project/authentication/patient/registration_screen/bloc/registration_page_bloc.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController =
      TextEditingController(); // New controller for Age
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(); // New controller for Place
  final TextEditingController placeController =
      TextEditingController(); // New controller for Place

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = false;
  double? latitude;
  double? longitude;
  get loadFromJson => null;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    ageController.dispose(); // Dispose new controller
    addressController.dispose();
    phoneController.dispose(); // No longer needed for direct use
    placeController.dispose();
    super.dispose();
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> fetchLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showError('Location Services disabled');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showError('Location Permission denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showError('Location Permission denied forever');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    );

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  Widget buildLocationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: fetchLocation,
          style: ElevatedButton.styleFrom(
            backgroundColor: SereneTheme.primaryPink,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Icon(Icons.location_searching, color: Colors.white),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Latitude: ${latitude?.toStringAsFixed(6) ?? '0.0'}"),
            Text("Longitude: ${longitude?.toStringAsFixed(6) ?? '0.0'}"),
          ],
        ),
      ],
    );
  }

  Future<void> saveForm() async {
    print(123);
    FocusScope.of(context).unfocus();
    setState(() {
      isloading = true;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }
    setState(() {
      isloading = true;
    });
    print('after validation');

    print('Validation successful. Dispatching RegisterBlocEvent.');
    context.read<RegistrationPageBloc>().add(
      RegistrationPageEvent.patientRegistration(
        name: nameController.text,
        password: passwordController.text,
        email: emailController.text,
        phone: int.parse(phoneController.text),
        address: addressController.text,
        place: placeController.text,
        age: int.parse(ageController.text),
        role: 'user',
        longitude: double.parse(
          longitude!.toStringAsFixed(6),
        ), // Limit to 6 decimal places
        latitude: double.parse(latitude!.toStringAsFixed(6)),
      ),
    );
    // context.read<RegisterBlocBloc>().add(
    //   RegisterBlocEvent.userRegister(
    //     name: nameController.text,
    //     email: emailController.text.trim(),
    //     password: passwordController.text.trim(),
    //     age: ageController.text, // Pass age
    //     address: addressController.text,
    //     phone: phoneController.text,
    //   ),
    // );
  }

  Widget _buildTextField(
    String label, {
    required TextEditingController controller,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int? maxLines,
    bool obscureText = false, // Added for password
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        maxLines: maxLines ?? 1, // Use maxLines if provided, otherwise 1
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          border: AnimatedInputBorder(
            animationValue: _animationController.value,
          ),
          focusedBorder: AnimatedInputBorder(
            animationValue: _animationController.value,
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(width: 2.0, color: Color(0xFF163A57)),
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Create an Account',
            style: TextStyle(
              color: SereneTheme.darkPink,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: SereneTheme.darkPink),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocConsumer<RegistrationPageBloc, RegistrationPageState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () {
                setState(() => isloading = true);
              },
              success: (response) {
                setState(() => isloading = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Registration Successful"),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
              error: (error) {
                setState(() => isloading = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error: $error"),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    SereneTheme.lightPink,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Card(
                  elevation: 6,
                  // semanticContainer: true,
                  borderOnForeground: true,
                  shadowColor: Colors.black,
                  margin: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: 35,
                    ),
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) => Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                _buildTextField(
                                  "Name",
                                  controller: nameController,
                                  validator: (value) => value!.isEmpty
                                      ? "Please enter name"
                                      : null,
                                ),
                                const SizedBox(height: 10), // Reduced spacing
                                _buildTextField(
                                  "Email",
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter email";
                                    }
                                    final emailRegex = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                    );
                                    if (!emailRegex.hasMatch(value)) {
                                      return "Invalid email";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10), // Reduced spacing
                                _buildTextField(
                                  "Password",
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true, // Make password obscure
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter password";
                                    }
                                    if (value.length < 6) {
                                      return "Min 6 characters";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10), // Reduced spacing
                                _buildTextField(
                                  "Age",
                                  controller: ageController,
                                  keyboardType: TextInputType
                                      .number, // Age should be a number
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your age";
                                    }
                                    if (int.tryParse(value) == null ||
                                        int.parse(value) <= 0) {
                                      return "Please enter a valid age";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                _buildTextField(
                                  "Phone Number",
                                  controller: phoneController,
                                  keyboardType: TextInputType
                                      .phone, // Age should be a number
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your Phone Number";
                                    }
                                    if (int.tryParse(value) == null ||
                                        int.parse(value) <= 0) {
                                      return "Please enter a valid age";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10), // Reduced spacing
                                _buildTextField(
                                  "Address",
                                  maxLines: 3,
                                  controller: addressController,
                                  keyboardType: TextInputType.streetAddress,
                                  validator: (value) => value!.isEmpty
                                      ? "Please enter address"
                                      : null,
                                ), 
                                 const SizedBox(height: 10), // Reduced spacing
                                _buildTextField(
                                  "Place",
                                  controller: placeController,
                                  validator: (value) => value!.isEmpty
                                      ? "Please enter Place"
                                      : null,
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Get Location'),
                                ),
                                const SizedBox(height: 10),
                                buildLocationButton(),

                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: saveForm,
                                  child: isloading
                                      ? const CircularProgressIndicator(color: Colors.white)
                                      : const Text("REGISTER"),
                                ),
                                SizedBox(height: h * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (ctx) =>
                                                const LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 85, 5, 66),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
          },
        ),
      ),
    );
  }
}
