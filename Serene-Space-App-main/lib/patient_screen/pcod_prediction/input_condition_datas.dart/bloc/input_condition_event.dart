part of 'input_condition_bloc.dart';

@freezed
class InputConditionEvent with _$InputConditionEvent {
  const factory InputConditionEvent.started() = _Started;
const factory InputConditionEvent.mentalHealthSubmit({
  required int userId,
  required Map<String, String> answers,
}) = _MentalHealthSubmit;


  
}