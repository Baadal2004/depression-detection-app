import 'dart:convert';

MentalHealthResponse mentalHealthResponseFromJson(String str) =>
    MentalHealthResponse.fromJson(json.decode(str));

class MentalHealthResponse {
  final String status;
  final String prediction;
  final MentalHealthData data;

  MentalHealthResponse({
    required this.status,
    required this.prediction,
    required this.data,
  });

  factory MentalHealthResponse.fromJson(Map<String, dynamic> json) {
    return MentalHealthResponse(
      status: json["status"],
      prediction: json["prediction"],
      data: MentalHealthData.fromJson(json["data"]),
    );
  }
}

class MentalHealthData {
  final int id;
  final int user;
  final String predictionResult;

  final String sadness;
  final String euphoric;
  final String exhausted;
  final String sleepDisorder;
  final String moodSwing;
  final String suicidalThoughts;
  final String anorexia;
  final String authorityRespect;
  final String tryExplanation;
  final String aggressiveResponse;
  final String ignoreMoveOn;
  final String nervousBreakdown;
  final String admitMistakes;
  final String overthinking;

  MentalHealthData({
    required this.id,
    required this.user,
    required this.predictionResult,
    required this.sadness,
    required this.euphoric,
    required this.exhausted,
    required this.sleepDisorder,
    required this.moodSwing,
    required this.suicidalThoughts,
    required this.anorexia,
    required this.authorityRespect,
    required this.tryExplanation,
    required this.aggressiveResponse,
    required this.ignoreMoveOn,
    required this.nervousBreakdown,
    required this.admitMistakes,
    required this.overthinking,
  });

  factory MentalHealthData.fromJson(Map<String, dynamic> json) {
    return MentalHealthData(
      id: json["id"],
      user: json["user"],
      predictionResult: json["prediction_result"],
      sadness: json["sadness"],
      euphoric: json["euphoric"],
      exhausted: json["exhausted"],
      sleepDisorder: json["sleep_disorder"],
      moodSwing: json["mood_swing"],
      suicidalThoughts: json["suicidal_thoughts"],
      anorexia: json["anorexia"],
      authorityRespect: json["authority_respect"],
      tryExplanation: json["try_explanation"],
      aggressiveResponse: json["aggressive_response"],
      ignoreMoveOn: json["ignore_move_on"],
      nervousBreakdown: json["nervous_breakdown"],
      admitMistakes: json["admit_mistakes"],
      overthinking: json["overthinking"],
    );
  }
}
