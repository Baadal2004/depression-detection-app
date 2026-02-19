class AdhdPredictionModel {
  final int id;
  final int user;
  final int age;
  final String gender;
  final double sleepHourAvg;

  final int easilyDistracted;
  final int forgetfulDailyTasks;
  final int poorOrganization;
  final int difficultySustainingAttention;
  final int restlessness;
  final int impulsivityScore;

  final double screenTimeDaily;
  final int phoneUnlocksPerDay;
  final int workingMemoryScore;

  final int symptomScore;
  final String adhdResult;
  final String createdAt;

  AdhdPredictionModel({
    required this.id,
    required this.user,
    required this.age,
    required this.gender,
    required this.sleepHourAvg,
    required this.easilyDistracted,
    required this.forgetfulDailyTasks,
    required this.poorOrganization,
    required this.difficultySustainingAttention,
    required this.restlessness,
    required this.impulsivityScore,
    required this.screenTimeDaily,
    required this.phoneUnlocksPerDay,
    required this.workingMemoryScore,
    required this.symptomScore,
    required this.adhdResult,
    required this.createdAt,
  });

  /// ✅ Convert JSON → Model
  factory AdhdPredictionModel.fromJson(Map<String, dynamic> json) {
    return AdhdPredictionModel(
      id: json['id'] ?? 0,
      user: json['user'] ?? 0,
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      sleepHourAvg:
          (json['sleep_hour_avg'] ?? 0).toDouble(),

      easilyDistracted: json['easily_distracted'] ?? 0,
      forgetfulDailyTasks: json['forgetful_daily_tasks'] ?? 0,
      poorOrganization: json['poor_organization'] ?? 0,
      difficultySustainingAttention:
          json['difficulty_sustaining_attention'] ?? 0,
      restlessness: json['restlessness'] ?? 0,
      impulsivityScore: json['impulsivity_score'] ?? 0,

      screenTimeDaily:
          (json['screen_time_daily'] ?? 0).toDouble(),
      phoneUnlocksPerDay:
          json['phone_unlocks_per_day'] ?? 0,
      workingMemoryScore:
          json['working_memory_score'] ?? 0,

      symptomScore: json['symptom_score'] ?? 0,
      adhdResult: json['adhd_prediction'] ?? '',

      createdAt: json['created_at'] ?? '',
    );
  }

  /// ✅ Convert Model → JSON (for POST / PUT)
  Map<String, dynamic> toJson() {
    return {
      "user": user,
      "age": age,
      "gender": gender,
      "sleep_hour_avg": sleepHourAvg,
      "easily_distracted": easilyDistracted,
      "forgetful_daily_tasks": forgetfulDailyTasks,
      "poor_organization": poorOrganization,
      "difficulty_sustaining_attention":
          difficultySustainingAttention,
      "restlessness": restlessness,
      "impulsivity_score": impulsivityScore,
      "screen_time_daily": screenTimeDaily,
      "phone_unlocks_per_day": phoneUnlocksPerDay,
      "working_memory_score": workingMemoryScore,
    };
  }
}
