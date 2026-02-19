// ...existing code...
part of 'list_nearest_doctors_bloc.dart';

@freezed
class ListNearestDoctorsEvent with _$ListNearestDoctorsEvent {
  const factory ListNearestDoctorsEvent.started() = _Started;
  const factory ListNearestDoctorsEvent.viewNearestDoctors({
    required double latitude,
    required double longitude,
    String? authToken,
  }) = _ViewNearestDoctors;
}