part of 'list_nearest_doctors_bloc.dart';

@freezed
class ListNearestDoctorsState with _$ListNearestDoctorsState {
  const factory ListNearestDoctorsState.initial() = _Initial;
  const factory ListNearestDoctorsState.loading() = _Loading;
  const factory ListNearestDoctorsState.success({required NearestDoctorsResponse response}) = _Success;
  const factory ListNearestDoctorsState.error({required String error}) = _Error;
  
  
  
}
