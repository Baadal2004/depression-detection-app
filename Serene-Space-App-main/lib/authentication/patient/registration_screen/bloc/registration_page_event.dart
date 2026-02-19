part of 'registration_page_bloc.dart';

@freezed
class RegistrationPageEvent with _$RegistrationPageEvent {
  const factory RegistrationPageEvent.started() = _Started;
  const factory RegistrationPageEvent.patientRegistration({
    required String name,
    required String password,
    required String email,
    required int phone,
    required String address,
    required String place,
    required int age,
    required String role,
    required double latitude,
    required double longitude,
  }) = _PatientRegistration;
  
}