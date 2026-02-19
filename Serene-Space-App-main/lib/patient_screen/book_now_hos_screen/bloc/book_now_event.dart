part of 'book_now_bloc.dart';

@freezed
class BookHosEvent with _$BookHosEvent {
  const factory BookHosEvent.started() = _Started;
  const factory BookHosEvent.bookNow({required int doctorId}) = _BookNow;
}
