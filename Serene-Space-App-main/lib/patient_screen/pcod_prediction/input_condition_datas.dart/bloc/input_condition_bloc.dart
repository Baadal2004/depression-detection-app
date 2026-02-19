
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serene_space_project/patient_screen/pcod_prediction/input_condition_datas.dart/input_condition_model.dart';
import 'package:serene_space_project/patient_screen/pcod_prediction/input_condition_datas.dart/input_condition_service.dart';

part 'input_condition_event.dart';
part 'input_condition_state.dart';
part 'input_condition_bloc.freezed.dart';

class InputConditionBloc
    extends Bloc<InputConditionEvent, InputConditionState> {
  InputConditionBloc() : super(_Initial()) {
    on<InputConditionEvent>((event, emit) async {
      

    
     if (event is _MentalHealthSubmit) {
  emit(const InputConditionState.loading());

  try {
    final response = await submitMentalHealthForm(
      user: event.userId,
      answers: event.answers,
    );

    emit(InputConditionState.success(response: response));
  } catch (e) {
    emit(InputConditionState.error(error: e.toString()));
  }
}

    });
  }
}
