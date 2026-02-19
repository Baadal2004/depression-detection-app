part of 'list_nearbyhos_bloc.dart';

@freezed
class ListNearbyhosEvent with _$ListNearbyhosEvent {
  const factory ListNearbyhosEvent.started() = _Started;
  const factory ListNearbyhosEvent.nearbydoc({
     required int userId,
  }) = _Nearbydoc;
  
}