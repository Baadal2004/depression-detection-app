part of 'input_cycle_bloc.dart';

@freezed
class InputCycleState with _$InputCycleState {
  const factory InputCycleState.initial() = _Initial;
  const factory InputCycleState.loading() = _Loading;
  const factory InputCycleState.success({required AdhdPredictionModel response}) = _Success;
  const factory InputCycleState.error({required String error}) = _Error;
  
  
  
}
