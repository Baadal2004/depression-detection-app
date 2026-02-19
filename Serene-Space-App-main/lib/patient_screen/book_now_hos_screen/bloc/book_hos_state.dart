part of 'book_now_bloc.dart';

@freezed
class BookHosState with _$BookHosState {
  const factory BookHosState.initial() = _Initial;
  const factory BookHosState.loading() = _Loading;
  const factory BookHosState.success({
    required List<HospitalDoctorSlotResponse> response,
  }) = _Success;
  const factory BookHosState.error({required String error}) = _Error;
}
