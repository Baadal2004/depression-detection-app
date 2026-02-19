import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serene_space_project/authentication/doctor_authentication/doctor_login/doctor_login_service.dart';

part 'doctor_login_event.dart';
part 'doctor_login_state.dart';
part 'doctor_login_bloc.freezed.dart';

class DoctorLoginBloc extends Bloc<DoctorLoginEvent, DoctorLoginState> {
  DoctorLoginBloc() : super(_Initial()) {
    on<DoctorLoginEvent>((event, emit) async {
       if (event is _DocLogin) {
        emit(const DoctorLoginState.loading());
        try {
          final response = await docLogins(
            role: event.role,
            email: event.email,
           doctorId: event.doctorId,
          );
          emit(DoctorLoginState.success(response: response));
        } catch (e) {
          emit(DoctorLoginState.error(error: e.toString()));
         // print('error:${e.toString()}');
        }
      }
    });
  }
}
