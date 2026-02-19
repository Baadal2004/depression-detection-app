import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serene_space_project/hospital_doctor_screen/dochospital_create/dochospital_create_slot_model.dart';
import 'package:serene_space_project/hospital_doctor_screen/dochospital_create/dochospital_create_slot_service.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';
part 'bloc_bloc.freezed.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  BlocBloc() : super(_Initial()) {
    on<BlocEvent>((event, emit) async {
      if (event is _UploadSlots) {
        emit(const BlocState.loading());
        try {
          final response = await createHosDoctorSlot(
            doctorId: event.clinicDoctor,
            date: event.date,
            startTime: event.startTime,
            endTime: event.endTime,
            timeslots: event.timeslots,
          );
          emit(BlocState.success(response: response));
        } catch (e) {
          emit(BlocState.error(error: e.toString()));
        }
      }
    });
  }
}
