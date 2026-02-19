// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animated_input_border/animated_input_border.dart';
import 'package:geolocator/geolocator.dart'; 
import 'package:geocoding/geocoding.dart';// Import for location services
import 'package:http/http.dart' as http;
import 'package:serene_space_project/authentication/doctor_authentication/doctor_login/doctor_login_view.dart';
import 'package:serene_space_project/authentication/doctor_authentication/registration_screen/bloc/register_bloc_bloc.dart';
import 'package:serene_space_project/authentication/patient/login_screen/login_view_page.dart';
import 'package:serene_space_project/constant_uri.dart';
// Import the phone number field package

class DoctorRegistrationPage extends StatefulWidget {
  const DoctorRegistrationPage({super.key});

  @override
  State<DoctorRegistrationPage> createState() => _DoctorRegistrationPageState();
}

class _DoctorRegistrationPageState extends State<DoctorRegistrationPage>
    with SingleTickerProviderStateMixin {
  final picker = ImagePicker();
  late AnimationController _animationController;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController hospitalnameController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController =
      TextEditingController(); // New controller for Age
  final TextEditingController addressController = TextEditingController();
  // We will no longer use a simple TextEditingController for phone.
  // We'll use the InternationalPhoneNumberInput's internal controller and callbacks.
  final TextEditingController placeController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(); // New controller for Place
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  String? _selectedGender;
  double? latitude;
  double? longitude;
  String _currentAddress = ''; // To display the fetched address
  Map<String, dynamic>? categoryChoices;
  String? errorMessage;
  String? selectedCategoryKey;

  final ImagePicker _picker = ImagePicker();

  File? _aadhaarImage;
  File? image;
  XFile? _profileImage;

  // Variables to store phone number details from InternationalPhoneNumberInput
  // String? _phoneNumber;
  // String? _phoneCountryCode;
  // String? _phoneDialCode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = false;

  get loadFromJson => null;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();
    _selectCategory();
  }

  @override
  void dispose() {
    _animationController.dispose();
    hospitalnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    ageController.dispose(); // Dispose new controller
    addressController.dispose();
    phoneController.dispose(); // No longer needed for direct use
    placeController.dispose();
    experienceController.dispose();
    specializationController.dispose();
    qualificationController.dispose();
    super.dispose();
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        setState(() {
          _profileImage = pickedFile;
        });
      }
    } catch (e) {
      showError("Failed to pick image: $e");
    }
  }

  void _showImageSourceSelection() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectCategory() async {
    try {
      final response = await http.get(Uri.parse(Urlsss.regDoctorUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          categoryChoices = data['category_choices'];
          errorMessage = null;
          selectedCategoryKey =
              categoryChoices?.keys.first; // select first by default (optional)
        });
      } else {
        setState(() {
          categoryChoices = null;
          errorMessage =
              'Failed to load categories: HTTP ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An unexpected error occurred';
        categoryChoices = null;
      });
    }
  }

  // Method to get current location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    //LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showError('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showError('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showError(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
      //await _getAddressFromLatLng(position);
    } catch (e) {
      showError("Error getting location: $e");
    }
  }

  // Method to get address from LatLng
  Future<void> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
        addressController.text = _currentAddress; // Set address to controller
        placeController.text = place.locality ?? ''; // Set place to controller
      });
    } catch (e) {
      showError("Error getting address: $e");
    }
  }

  // Future<String> loadFromJson() async {
  //   return await rootBundle.loadString('assets/countries/country_list_en.json');
  // }

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

    if (_selectedGender == null) {
      setState(() => isloading = false);
      showError("Please select gender");
      print("Gender not selected.");
      return;
    }

    // Basic validation for latitude/longitude
    if (latitude == null || longitude == null) {
      setState(() => isloading = false);
      showError("Please fetch your location.");
      print("Location not fetched.");
      return;
    }

    // Validate phone number details
    // if (_phoneNumber == null) {
    //   setState(() => isloading = false);
    //   showError("Please enter your phone number.");
    //   print("Phone number not entered.");
    //   return;
    // }
    // if (_phoneDialCode == null || _phoneDialCode!.isEmpty) {
    //   setState(() => isloading = false);
    //   showError("Please select a country code for your phone number.");
    //   print("Phone country code not selected.");
    //   return;
    // }

    print('Validation successful. Dispatching RegisterBlocEvent.');
    context.read<DocRegisterBlocBloc>().add(
      DocRegisterBlocEvent.docuserRegister(
        hospitalname: hospitalnameController.text,
        name: nameController.text,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        age: ageController.text, // Pass age
        address: addressController.text,
        phone: phoneController.text,
        gender: _selectedGender!,
        place: placeController.text, // Pass place
        latitude: double.parse(latitude!.toStringAsFixed(6)), // Pass latitude
        longitude: double.parse(longitude!.toStringAsFixed(6)),
        qualification: qualificationController.text,
        //  category: selectedCategoryKey!,
        experience: experienceController.text,
        medicalCertificate: XFile(_aadhaarImage!.path),
        profilePic: _profileImage!,
        specialzation: specializationController.text,
        // Pass longitude
      ),
    );
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

  Widget _buildGenderSelector() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Gender",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Radio<String>(
                value: "Male",
                // ignore: deprecated_member_use
                groupValue: _selectedGender,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              const Text("Male"),
              Radio<String>(
                value: "Female",
                // ignore: deprecated_member_use
                groupValue: _selectedGender,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              const Text("Female"),
            ],
          ),
          if (_selectedGender == null && !isloading)
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Please select gender",
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildCategorySelector() {
    if (categoryChoices == null) {
      if (errorMessage != null) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(errorMessage!, style: TextStyle(color: Colors.red)),
        );
      }
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      );
    }
    // This block will only run if categoryChoices is not null
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedCategoryKey,
        hint: const Text('Select Category'),
        items: categoryChoices!.entries.map((entry) {
          return DropdownMenuItem<String>(
            value: entry.key,
            child: Text(entry.value.toString()),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCategoryKey = value;
            // Handle additional logic as needed
          });
        },
      ),
    );
  }

  Widget _buildLocationButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Location",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _getCurrentLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ), // Changed color
                child: const Row(
                  children: [
                    Icon(
                      Icons.my_location,
                      color: Colors.white,
                    ), // Changed icon
                    SizedBox(width: 8),
                    //  Text("Get Location", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Latitude: ${latitude?.toStringAsFixed(6) ?? 'N/A'}",
                  ), // Changed default to N/A
                  Text("Longitude: ${longitude?.toStringAsFixed(6) ?? 'N/A'}"),
                ],
              ),
            ],
          ),
          if (latitude == null && longitude == null && !isloading)
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Please fetch your location",
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileImagePicker() {
    return Center(
      child: GestureDetector(
        onTap: _showImageSourceSelection,
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey[300],
          backgroundImage: _profileImage != null
              ? FileImage(File(_profileImage!.path))
              : null,
          child: _profileImage == null
              ? const Icon(Icons.camera_alt, size: 50, color: Colors.white70)
              : null,
        ),
      ),
    );
  }

  void showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take a Photo"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickAadhaarImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    ); // or ImageSource.camera
    if (image != null) {
      setState(() {
        _aadhaarImage = File(image.path);
      });
    }
  }

  Future<void> uploadAadhaarPhoto(BuildContext context) async {
    if (_aadhaarImage == null) return;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}userapp/userreg/'),
    );

    request.files.add(
      await http.MultipartFile.fromPath('aadhaar_photo', _aadhaarImage!.path),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      _showMessage(
        // ignore: use_build_context_synchronously
        context,
        "Aadhaar photo uploaded successfully!",
        Colors.green,
      );
    } else {
      _showMessage(
        // ignore: use_build_context_synchronously
        context,
        "Failed to upload Aadhaar photo. Please try again.",
        Colors.red,
      );
    }
  }

  void _showMessage(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 206, 233, 247),
        appBar: AppBar(
          title: const Text(
            'Register Your Account',
            style: TextStyle(
              color: Color.fromARGB(221, 57, 17, 73),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<DocRegisterBlocBloc, DocRegisterBlocState>(
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
                      return const DoctorLoginScreen();
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
              height: h,
              width: w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  isAntiAlias: true,
                  // invertColors: true,
                  opacity: 0.3,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/download (1).jpeg'),
                ),
              ),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Center(
                        child:
                            _buildProfileImagePicker(), // Just the profile image, no card here
                      ),
                      const SizedBox(height: 20),
                      Card(
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
                                        "Hospital Name",
                                        controller: hospitalnameController,
                                        validator: (value) => value!.isEmpty
                                            ? "Please enter Hospital Name"
                                            : null,
                                      ),
                                      const SizedBox(height: 10),

                                      _buildTextField(
                                        "Name",
                                        controller: nameController,
                                        validator: (value) => value!.isEmpty
                                            ? "Please enter name"
                                            : null,
                                      ),
                                      const SizedBox(height: 10),
                                      _buildTextField(
                                        "Qualification",
                                        controller: qualificationController,
                                        validator: (value) => value!.isEmpty
                                            ? "Please enter Qualification"
                                            : null,
                                      ),
                                      const SizedBox(height: 10),
                                      _buildGenderSelector(),
                                      const SizedBox(
                                        height: 10,
                                      ), // Reduced spacing
                                      _buildTextField(
                                        "Email",
                                        controller: emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
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
                                      const SizedBox(
                                        height: 10,
                                      ), // Reduced spacing
                                      _buildTextField(
                                        "Password",
                                        controller: passwordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText:
                                            true, // Make password obscure
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

                                      const SizedBox(
                                        height: 10,
                                      ), // Reduced spacing
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
                                        "Hospital Number",
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
                                      const SizedBox(height: 10),
                                      // buildCategorySelector(), // Reduced spacing
                                      // const SizedBox(height: 10),
                                      _buildTextField(
                                        "Specialization",
                                        controller: specializationController,
                                        validator: (value) => value!.isEmpty
                                            ? "Please enter Specialization"
                                            : null,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ), // Reduced spacing
                                      _buildTextField(
                                        "Experience",
                                        controller: experienceController,
                                        keyboardType: TextInputType
                                            .number, // Age should be a number
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter your Experience";
                                          }
                                          // if (int.tryParse(value) == null ||
                                          //     int.parse(value) <= 0) {
                                          //   return "Please enter a valid age";
                                          // }
                                          return null;
                                        },
                                      ),
                                      // InternationalPhoneNumberInput(
                                      //   height: 60,
                                      //   // No need for a separate controller here, the package manages it internally
                                      //   // inputFormatters: const [], // Removed this as it can conflict with the formatter
                                      //   formatter: MaskedInputFormatter(
                                      //     '### ### ## ##',
                                      //   ),
                                      //   initCountry: CountryCodeModel(
                                      //     name: "India",
                                      //     dial_code: "+91",
                                      //     code: "IN",
                                      //   ),

                                      //   betweenPadding: 23,
                                      //   onInputChanged: (phone) {
                                      //     // Update the state variables with the phone details
                                      //     setState(() {
                                      //       _phoneNumber = phone.number;
                                      //       _phoneCountryCode = phone.code;
                                      //       _phoneDialCode = phone.dial_code;
                                      //     });
                                      //     print(phone.code);
                                      //     print(phone.dial_code);
                                      //     print(phone.number);
                                      //     print(phone.rawFullNumber);
                                      //     print(phone.rawNumber);
                                      //     print(phone.rawDialCode);
                                      //   },
                                      //   loadFromJson: loadFromJson,
                                      //   dialogConfig: DialogConfig(
                                      //     backgroundColor: const Color(0xFF444448),
                                      //     searchBoxBackgroundColor: const Color(
                                      //       0xFF56565a,
                                      //     ),
                                      //     searchBoxIconColor: const Color(0xFFFAFAFA),
                                      //     countryItemHeight: 55,
                                      //     flatFlag: true,
                                      //     topBarColor: const Color(0xFF1B1C24),
                                      //     selectedItemColor: const Color(0xFF56565a),
                                      //     selectedIcon: Padding(
                                      //       padding: const EdgeInsets.only(left: 10),
                                      //       child: Image.asset(
                                      //         "assets/check.png",
                                      //         width: 20,
                                      //         fit: BoxFit.fitWidth,
                                      //       ),
                                      //     ),
                                      //     textStyle: TextStyle(
                                      //       color: const Color(
                                      //         0xFFFAFAFA,
                                      //       ).withOpacity(0.7),
                                      //       fontSize: 14,
                                      //       fontWeight: FontWeight.w600,
                                      //     ),
                                      //     searchBoxTextStyle: TextStyle(
                                      //       color: const Color(
                                      //         0xFFFAFAFA,
                                      //       ).withOpacity(0.7),
                                      //       fontSize: 14,
                                      //       fontWeight: FontWeight.w600,
                                      //     ),
                                      //     titleStyle: const TextStyle(
                                      //       color: Color(0xFFFAFAFA),
                                      //       fontSize: 18,
                                      //       fontWeight: FontWeight.w700,
                                      //     ),
                                      //     searchBoxHintStyle: TextStyle(
                                      //       color: const Color(
                                      //         0xFFFAFAFA,
                                      //       ).withOpacity(0.7),
                                      //       fontSize: 14,
                                      //       fontWeight: FontWeight.w600,
                                      //     ),
                                      //   ),
                                      //   countryConfig: CountryConfig(
                                      //     decoration: BoxDecoration(
                                      //       border: Border.all(
                                      //         width: 2,
                                      //         color: const Color(0xFF3f4046),
                                      //       ),
                                      //       borderRadius: BorderRadius.circular(8),
                                      //     ),
                                      //     flatFlag: true,
                                      //     noFlag: false,
                                      //     textStyle: const TextStyle(
                                      //       color: Colors.black,
                                      //       fontSize: 16,
                                      //       fontWeight: FontWeight.w600,
                                      //     ),
                                      //   ),
                                      //   validator: (number) {
                                      //     if (number == null ||
                                      //         number.number.isEmpty) {
                                      //       return "The phone number cannot be left empty";
                                      //     }
                                      //     // You might want to add more robust phone number validation here
                                      //     return null;
                                      //   },
                                      //   phoneConfig: PhoneConfig(
                                      //     focusedColor: const Color(0xFF6D59BD),
                                      //     enabledColor: const Color(0xFF6D59BD),
                                      //     errorColor: const Color(0xFFFF5494),
                                      //     labelStyle: null,
                                      //     labelText: null,
                                      //     floatingLabelStyle: null,
                                      //     focusNode: null,
                                      //     radius: 8,
                                      //     hintText: "Phone Number",
                                      //     borderWidth: 2,
                                      //     backgroundColor: Colors.transparent,
                                      //     decoration: null,
                                      //     popUpErrorText: true,
                                      //     autoFocus: false,
                                      //     showCursor: false,
                                      //     textInputAction: TextInputAction.done,
                                      //     autovalidateMode:
                                      //         AutovalidateMode.onUserInteraction,
                                      //     errorTextMaxLength: 2,
                                      //     errorPadding: const EdgeInsets.only(
                                      //       top: 14,
                                      //     ),
                                      //     errorStyle: const TextStyle(
                                      //       color: Color(0xFFFF5494),
                                      //       fontSize: 12,
                                      //       height: 1,
                                      //     ),
                                      //     textStyle: const TextStyle(
                                      //       color: Colors.black,
                                      //       fontSize: 16,
                                      //       fontWeight: FontWeight.w400,
                                      //     ),
                                      //     hintStyle: TextStyle(
                                      //       color: Colors.black.withOpacity(0.5),
                                      //       fontSize: 16,
                                      //       fontWeight: FontWeight.w400,
                                      //     ),
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        height: 10,
                                      ), // Reduced spacing
                                      _buildTextField(
                                        "Hospital Address",
                                        maxLines: 3,
                                        controller: addressController,
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        validator: (value) => value!.isEmpty
                                            ? "Please enter address"
                                            : null,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ), // Reduced spacing
                                      _buildTextField(
                                        "Place",
                                        controller: placeController,
                                        keyboardType: TextInputType.text,
                                        validator: (value) => value!.isEmpty
                                            ? "Please enter place"
                                            : null,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ), // Reduced spacing
                                      _buildLocationButton(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // ignore: unnecessary_null_comparison
                                          _aadhaarImage != null
                                              ? Image.file(
                                                  _aadhaarImage!,
                                                  height: 150,
                                                )
                                              : const Text(
                                                  "",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                          const SizedBox(height: 10),
                                          ElevatedButton.icon(
                                            style: const ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                    Color.fromARGB(
                                                      255,
                                                      255,
                                                      255,
                                                      255,
                                                    ),
                                                  ),
                                            ),
                                            onPressed: _pickAadhaarImage,
                                            icon: const Icon(
                                              Icons.upload,
                                              color: Color.fromARGB(
                                                255,
                                                44,
                                                108,
                                                161,
                                              ),
                                            ),
                                            label: const Text(
                                              "Upload Medical Certificate",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                  255,
                                                  44,
                                                  108,
                                                  161,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      // ElevatedButton.icon(
                                      //   style: ElevatedButton.styleFrom(
                                      //     backgroundColor: Colors.white,
                                      //   ),
                                      //   onPressed: _showImageSourceDialog,
                                      //   icon: const Icon(
                                      //     Icons.upload_file,
                                      //     color: Color.fromARGB(255, 44, 108, 161),
                                      //   ),
                                      //   label: const Text(
                                      //     "Upload Supporting Evidence",
                                      //     style: TextStyle(
                                      //       color: Color.fromARGB(255, 44, 108, 161),
                                      //       fontSize: 15,
                                      //     ),
                                      //   ),
                                      // ),
                                      // const SizedBox(height: 20),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          fixedSize: WidgetStatePropertyAll(
                                            Size(w * 0.9, 50),
                                          ),
                                          shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          backgroundColor:
                                              const WidgetStatePropertyAll(
                                                Colors.blueGrey,
                                              ),
                                        ),
                                        onPressed: saveForm,
                                        child: isloading
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : const Text(
                                                "REGISTER",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ),
                                      SizedBox(height: h * 0.02),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                              Navigator.of(
                                                context,
                                              ).pushReplacement(
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
                                                color: Colors.blueGrey,
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
                    ],
                  ),
                ),
              ),
              // );
              // },
              // ),
            );
          },
        ),
      ),
    );
  }
}
