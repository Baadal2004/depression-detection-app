import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:serene_space_project/constant_uri.dart';
import 'package:serene_space_project/screens/menstrual_track/input_cycle/input_cycle_model.dart';

Future<AdhdPredictionModel> predictADHD({
  required int userId,
  required int age,
  required String gender,
  required double sleepingHour,
  required String distracted,
  required String forgetful,
  required String poorOrganization,
  required String sustainingAttention,
  required String restlessness,
  required String impulsivityScore,
  required double screenTime,
  required double phoneUnlocks,
  required double workingHour


}) async {
  try {
    final Map<String, dynamic> body = {
     "user": userId,
    "age": age,
    "gender": gender,
    "sleep_hour_avg": sleepingHour,
    "easily_distracted": distracted,
    "forgetful_daily_tasks": forgetful,
    "poor_organization": poorOrganization,
    "difficulty_sustaining_attention": sustainingAttention,
    "restlessness":restlessness,
    "impulsivity_score": impulsivityScore,
    "screen_time_daily":screenTime,
    "phone_unlocks_per_day": phoneUnlocks,
    "working_memory_score":workingHour,

    };
    final res = await http.post(
      Uri.parse(Urlsss.periodsInputCycle),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    //print(res);
   // print(Urlsss.periodsInputCycle);
    final Map<String, dynamic> decoded = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      final response = AdhdPredictionModel.fromJson(decoded);
      return response;
    }
    else {
      throw Exception("Failed to register user: ${res.statusCode}");
    }
  }
   on SocketException {
    throw Exception('Server Error');
  } on HttpException {
    throw Exception('Something went wrong');
  } on FormatException {
    throw Exception('Bad Request');
  }
   catch (e) {
     throw Exception(e.toString());
   }
}
