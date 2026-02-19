import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:serene_space_project/authentication/doctor_authentication/registration_screen/doc_registration_page_model.dart';
import 'package:serene_space_project/constant_uri.dart';

Future<HospitalRegModel> docuserRegister({
  required String hospitalname,
  required String name,
  required String password,
  required String email,
  required int phone,
  required String address,
  required String gender,
  required int age,
  required String place,
  required String latitude,
  required String longitude,
  required String qualification,
  required String experience,
  required String specialzation,
  required XFile profilePic,
  required XFile medicalCertificate,
}) async {
  try {
    // Prepare the multipart request
    var request = http.MultipartRequest('POST', Uri.parse(Urlsss.regDoctorUrl));

    // Adding text fields
    request.fields['hospital_name'] = hospitalname;
    request.fields['name'] = name;
    request.fields['password'] = password;
    request.fields['email'] = email;
    request.fields['hospital_phone'] = phone.toString();
    request.fields['hospital_address'] = address;
    request.fields['gender'] = gender;
    request.fields['age'] = age.toString();
    request.fields['place'] = place;
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;
    request.fields['qualification'] = qualification;
    request.fields['experience'] = experience;
    request.fields['specialization'] = specialzation;
    request.fields['role'] = 'doctor';

    // If role is important for backend, uncomment and set it:
    //
    // Add files (with correct field names matching backend API)
    request.files.add(
      await http.MultipartFile.fromPath(
        'image', // backend field for profile pic
        profilePic.path,
      ),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'medical_id', // backend field for medical certificate
        medicalCertificate.path,
      ),
    );

    // Sending request
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

   // print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decoded = jsonDecode(response.body);
      return HospitalRegModel.fromJson(decoded);
    } else {
      throw Exception("Failed to register user: ${response.statusCode}");
    }
  } on SocketException {
    throw Exception('Server Error');
  } on HttpException {
    throw Exception('Something went wrong');
  } on FormatException {
    throw Exception('Bad Request');
  } catch (e) {
    throw Exception(e.toString());
  }
}
