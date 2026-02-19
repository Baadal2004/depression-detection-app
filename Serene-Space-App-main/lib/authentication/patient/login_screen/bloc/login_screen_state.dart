part of 'login_screen_bloc.dart';

@freezed
class LoginScreenState with _$LoginScreenState {
  const factory LoginScreenState.initial() = _Initial;
  const factory LoginScreenState.loading() = _Loading;
  const factory LoginScreenState.success({required UserLoginModel response}) = _Success;
  const factory LoginScreenState.error({required String error}) = _Error;
  
  
  
}
