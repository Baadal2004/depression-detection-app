import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serene_space_project/authentication/patient/registration_screen/registration_page_model.dart';
import 'package:serene_space_project/authentication/patient/registration_screen/registration_page_services.dart';

part 'registration_page_event.dart';
part 'registration_page_state.dart';
part 'registration_page_bloc.freezed.dart';

class RegistrationPageBloc
    extends Bloc<RegistrationPageEvent, RegistrationPageState> {
  RegistrationPageBloc() : super(_Initial()) {
    on<RegistrationPageEvent>((event, emit) async {
      if (event is _PatientRegistration) {
        emit(const RegistrationPageState.loading());
        try {
          final response = await userRegister(
            name: event.name,
            password: event.password,
            email: event.email,
            phone: event.phone,
            address: event.address,
            place: event.place,
            age: event.age,
            role: event.role,
            latitude: event.latitude,
            longitude: event.longitude,
          );
          emit(RegistrationPageState.success(response: response));
        } catch (e) {
          emit(RegistrationPageState.error(error: e.toString()));
         // print('error:${e.toString()}');
        }
      }
    });
  }
}
