part of 'input_cycle_bloc.dart';

@freezed
class InputCycleEvent with _$InputCycleEvent {
  const factory InputCycleEvent.started() = _Started;
  const factory InputCycleEvent.predictADHD({
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
    required double workingHour,
  }) = _PredictADHD;
}
