import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:serene_space_project/authentication/patient/login_screen/login_model_page.dart';
import 'package:serene_space_project/constant_uri.dart';

Future<UserLoginModel> userLogins({
  required String role,
  required String email,
  required String password,
  //  required this.role,
  //  required this.email,
  //  required this.password
}) async {
  try {
    final Map<String, dynamic> body = {
      "role": role,
      "email": email,
      "password": password,

      // "user_type": userType,
      // "email": email,
      // "password": password,
    };
    final url = Urlsss.loginUrl;
   // print("Login URL: $url");
    final res = await http.post(
      Uri.parse(url),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
   // print(res.body);
    //print("Login URL: ${Urlsss.loginUrl}");
  //  print("Request body: ${jsonEncode(body)}");
   // print("Response status: ${res.statusCode}");
    final Map<String, dynamic> decoded = jsonDecode(res.body);

    if (res.statusCode == 200) {
      final response = UserLoginModel.fromJson(decoded);
      return response;
    } else {
      throw Exception("Failed to login User ${res.statusCode}");
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
