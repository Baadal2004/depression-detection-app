part of 'bloc_bloc.dart';

@freezed
class BlocEvent with _$BlocEvent {
  const factory BlocEvent.started() = _Started;
  const factory BlocEvent.uploadSlots({
     required int clinicDoctor,
    required String date,
    required String startTime,
    required String endTime,
    required List<String> timeslots,
  }) = _UploadSlots;
  
}