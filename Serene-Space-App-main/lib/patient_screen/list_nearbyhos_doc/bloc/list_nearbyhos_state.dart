part of 'list_nearbyhos_bloc.dart';

@freezed
class ListNearbyhosState with _$ListNearbyhosState {
  const factory ListNearbyhosState.initial() = _Initial;
  const factory ListNearbyhosState.loading() = _Loading;
  const factory ListNearbyhosState.success({required List<NearbyHosDoctor> response}) = _Success;
  const factory ListNearbyhosState.error({required String error}) = _Error;
  
  
  
}
