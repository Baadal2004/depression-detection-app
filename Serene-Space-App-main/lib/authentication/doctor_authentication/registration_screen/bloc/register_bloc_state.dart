part of 'register_bloc_bloc.dart';

@freezed
class DocRegisterBlocState with _$DocRegisterBlocState {
  const factory DocRegisterBlocState.initial() = _Initial;
  const factory DocRegisterBlocState.loading() = _Loading;
  const factory DocRegisterBlocState.success({
    required HospitalRegModel response,
  }) = _Success;
  const factory DocRegisterBlocState.error({required String error}) = _Error;
}
