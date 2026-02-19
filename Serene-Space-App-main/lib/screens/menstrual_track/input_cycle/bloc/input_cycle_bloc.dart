import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serene_space_project/screens/menstrual_track/input_cycle/input_cycle_model.dart';
import 'package:serene_space_project/screens/menstrual_track/input_cycle/input_cycle_service.dart';

part 'input_cycle_event.dart';
part 'input_cycle_state.dart';
part 'input_cycle_bloc.freezed.dart';

class InputCycleBloc extends Bloc<InputCycleEvent, InputCycleState> {
  InputCycleBloc() : super(_Initial()) {
    on<InputCycleEvent>((event, emit) async {
       if (event is _PredictADHD) {
        emit(const InputCycleState.loading());
        try {
          final response = await predictADHD(
            userId: event.userId,
            age: event.age,
            gender: event.gender,
            sleepingHour: event.sleepingHour,
            distracted: event.distracted,
            forgetful: event.forgetful,
            poorOrganization: event.poorOrganization,
            sustainingAttention: event.sustainingAttention,
            restlessness: event.restlessness,
            impulsivityScore: event.impulsivityScore,
            screenTime: event.screenTime,
            phoneUnlocks: event.phoneUnlocks,
            workingHour: event.workingHour,
          );
          emit(InputCycleState.success(response: response));
        } catch (e) {
          emit(InputCycleState.error(error: e.toString()));
        }
      }
    });
  }
}
