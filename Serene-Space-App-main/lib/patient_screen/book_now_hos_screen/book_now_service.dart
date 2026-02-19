import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'book_now_model.dart';
import 'package:serene_space_project/constant_uri.dart';

Future<List<HospitalDoctorSlotResponse>> bookHosService({
  required int doctorId,
}) async {
  final url =
      '${baseUrl}userapp/hospital/doctor/$doctorId/timeslots/';
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body) as List<dynamic>;
      return decoded
          .map((item) => HospitalDoctorSlotResponse.fromJson(item))
          .toList();
    } else {
      throw Exception("Failed to fetch timeslots: ${response.statusCode}");
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
