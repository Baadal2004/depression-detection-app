import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serene_space_project/authentication/patient/login_screen/login_model_page.dart';
import 'package:serene_space_project/authentication/patient/login_screen/login_service_page.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';
part 'login_screen_bloc.freezed.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(_Initial()) {
    on<LoginScreenEvent>((event, emit) async {
      if (event is _UserLogin) {
        emit(const LoginScreenState.loading());
        try {
          final response = await userLogins(
            role: event.role,
            email: event.email,
            password: event.password,
          );
          emit(LoginScreenState.success(response: response));
        } catch (e) {
          emit(LoginScreenState.error(error: e.toString()));
        //  print('error:${e.toString()}');
        }
      }
    });
  }
}
