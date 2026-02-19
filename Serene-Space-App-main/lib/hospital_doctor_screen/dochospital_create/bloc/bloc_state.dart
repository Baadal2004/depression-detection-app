part of 'bloc_bloc.dart';


@freezed
class BlocState with _$BlocState {
  const factory BlocState.initial() = _Initial;
   const factory BlocState.loading() = _Loading;
  const factory BlocState.success({required HospitalDoctorSlotModel response}) = _Success;
  const factory BlocState.error({required String error}) = _Error;
  
  
}
