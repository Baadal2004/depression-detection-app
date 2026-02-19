import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serene_space_project/patient_screen/list_nearbyhos_doc/list_nearbyhos_doc_model.dart';
import 'package:serene_space_project/patient_screen/list_nearbyhos_doc/list_nearbyhos_doc_service.dart';

part 'list_nearbyhos_event.dart';
part 'list_nearbyhos_state.dart';
part 'list_nearbyhos_bloc.freezed.dart';

class ListNearbyhosBloc extends Bloc<ListNearbyhosEvent, ListNearbyhosState> {
  ListNearbyhosBloc() : super(_Initial()) {
    on<ListNearbyhosEvent>((event, emit) async{
      if (event is _Nearbydoc) {
        emit(const ListNearbyhosState.loading());
        try {
          final response = await listofNearestHosDoc(
           
            userId: event.userId
          );
          emit(ListNearbyhosState.success(response: response));
        } catch (e) {
          emit(ListNearbyhosState.error(error: e.toString()));
          //print('error:${e.toString()}');
        }
      }
    });
  }
}
