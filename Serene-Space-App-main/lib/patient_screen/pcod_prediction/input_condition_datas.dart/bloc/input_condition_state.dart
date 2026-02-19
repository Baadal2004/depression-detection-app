part of 'input_condition_bloc.dart';

@freezed
class InputConditionState with _$InputConditionState {
  const factory InputConditionState.initial() = _Initial;
  const factory InputConditionState.loading() = _loading;
  const factory InputConditionState.success({required MentalHealthResponse response}) = _success;
  const factory InputConditionState.error({required String error}) = _error;
}
