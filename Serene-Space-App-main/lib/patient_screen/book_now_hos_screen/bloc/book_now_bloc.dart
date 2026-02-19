import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serene_space_project/patient_screen/book_now_hos_screen/book_now_model.dart';
import 'package:serene_space_project/patient_screen/book_now_hos_screen/book_now_service.dart';
part 'book_now_event.dart';
part 'book_hos_state.dart';
part 'book_now_bloc.freezed.dart';

class BookHosBloc extends Bloc<BookHosEvent, BookHosState> {
  BookHosBloc() : super(_Initial()) {
    on<BookHosEvent>((event, emit) async {
      if (event is _BookNow) {
        emit(const BookHosState.loading());
        try {
          final response = await bookHosService(doctorId: event.doctorId);
          emit(BookHosState.success(response: response));
        } catch (e) {
          emit(BookHosState.error(error: e.toString()));
        }
      }
    });
  }
}
