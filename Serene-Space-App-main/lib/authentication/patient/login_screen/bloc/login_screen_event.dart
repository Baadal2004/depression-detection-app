part of 'login_screen_bloc.dart';

@freezed
class LoginScreenEvent with _$LoginScreenEvent {
  const factory LoginScreenEvent.started() = _Started;
  const factory LoginScreenEvent.userLogin({
    required String role,
    required String email,
    required String password,
  }) = _UserLogin;
  
}