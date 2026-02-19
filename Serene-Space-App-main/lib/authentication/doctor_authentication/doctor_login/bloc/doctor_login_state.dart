part of 'doctor_login_bloc.dart';

@freezed
class DoctorLoginState with _$DoctorLoginState {
  const factory DoctorLoginState.initial() = _Initial;
  const factory DoctorLoginState.loading() = _Loading;
  const factory DoctorLoginState.success({required response}) = _Success;
  const factory DoctorLoginState.error({required String error }) = _Error;
  
  
  
}
