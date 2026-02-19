import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:serene_space_project/constant_uri.dart';
import 'package:serene_space_project/patient_screen/pcod_prediction/input_condition_datas.dart/input_condition_model.dart';

Future<MentalHealthResponse> submitMentalHealthForm({
  required int user,
  required Map<String, dynamic> answers,
}) async {

  final url = Uri.parse(Urlsss.advancedPredictUrl);

  final body = {
    "user": user,
    ...answers,
  };

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(body),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return mentalHealthResponseFromJson(response.body);
  } else {
    throw Exception("Failed: ${response.body}");
  }
}
