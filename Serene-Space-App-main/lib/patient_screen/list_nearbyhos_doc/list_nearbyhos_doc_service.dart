import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:serene_space_project/patient_screen/list_nearbyhos_doc/list_nearbyhos_doc_model.dart';
import 'package:serene_space_project/constant_uri.dart';

Future<List<NearbyHosDoctor>> listofNearestHosDoc({required int userId}) async {
  try {
    final url =
        '${baseUrl}userapp/view_nearby_hospital_doctors/$userId/';
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{'Content-Type': 'application/json'},
    );
  //  print(url);
   // print(response);
    if (response.statusCode == 200) {
    //  print(response.statusCode);
    //  print(response.body);
      final Map<String, dynamic> decoded = jsonDecode(response.body);
     // print(decoded);
      final List<dynamic> list = decoded['nearby_hospital_doctors'] ?? [];
      return list.map((e) => NearbyHosDoctor.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch doctors: ${response.statusCode}");
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
