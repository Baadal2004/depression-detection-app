part of 'registration_page_bloc.dart';

@freezed
class RegistrationPageState with _$RegistrationPageState {
  const factory RegistrationPageState.initial() = _Initial;
  const factory RegistrationPageState.loading() = _Loading;
  const factory RegistrationPageState.success({required PatientRegistrationModel response}) = _Success;
  const factory RegistrationPageState.error({required String error}) = _Error;
  
  
  
}
