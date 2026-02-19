import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serene_space_project/authentication/doctor_authentication/registration_screen/doc_registration_page_model.dart';
import 'package:serene_space_project/authentication/doctor_authentication/registration_screen/doc_registration_page_services.dart';

part 'register_bloc_bloc.freezed.dart';
part 'register_bloc_event.dart';
part 'register_bloc_state.dart';

class DocRegisterBlocBloc
    extends Bloc<DocRegisterBlocEvent, DocRegisterBlocState> {
  DocRegisterBlocBloc() : super(DocRegisterBlocState.initial()) {
    on<DocRegisterBlocEvent>((event, emit) async {
      if (event is _DocUserRegister) {
        emit(const DocRegisterBlocState.loading());
        try {
          final response = await docuserRegister(
            hospitalname: event.hospitalname,
            name: event.name,
            password: event.password,
            email: event.email,
            phone: int.parse(event.phone),
            address: event.address,
            age: int.parse(event.age),
            place: event.place,
            latitude: event.latitude.toString(),
            longitude: event.longitude.toString(),
            gender: event.gender,
            qualification: event.qualification,
            experience: event.experience,
            specialzation: event.specialzation,
            profilePic: event.profilePic,
            medicalCertificate: event.medicalCertificate,
            //age: event.a
            // age: event.a,
            // place: event.place,
            //  latitude: event.latitude,
            // longitude: event.longitude
            //id: event.id,
          );
          emit(DocRegisterBlocState.success(response: response));
        } catch (e) {
          emit(DocRegisterBlocState.error(error: e.toString()));
          //print('error:${e.toString()}');
        }
      }
    });
  }
}
