part of 'doctor_login_bloc.dart';

@freezed
class DoctorLoginEvent with _$DoctorLoginEvent {
  const factory DoctorLoginEvent.started() = _Started;
  const factory DoctorLoginEvent.docLogin(
    {
      required String role,
      required String email,
      required String doctorId,
    }
  ) = _DocLogin;
  
}