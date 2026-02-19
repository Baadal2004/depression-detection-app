// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_nearest_doctors_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ListNearestDoctorsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListNearestDoctorsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListNearestDoctorsEvent()';
}


}

/// @nodoc
class $ListNearestDoctorsEventCopyWith<$Res>  {
$ListNearestDoctorsEventCopyWith(ListNearestDoctorsEvent _, $Res Function(ListNearestDoctorsEvent) __);
}


/// Adds pattern-matching-related methods to [ListNearestDoctorsEvent].
extension ListNearestDoctorsEventPatterns on ListNearestDoctorsEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _ViewNearestDoctors value)?  viewNearestDoctors,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _ViewNearestDoctors() when viewNearestDoctors != null:
return viewNearestDoctors(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _ViewNearestDoctors value)  viewNearestDoctors,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _ViewNearestDoctors():
return viewNearestDoctors(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _ViewNearestDoctors value)?  viewNearestDoctors,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _ViewNearestDoctors() when viewNearestDoctors != null:
return viewNearestDoctors(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( double latitude,  double longitude,  String? authToken)?  viewNearestDoctors,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _ViewNearestDoctors() when viewNearestDoctors != null:
return viewNearestDoctors(_that.latitude,_that.longitude,_that.authToken);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( double latitude,  double longitude,  String? authToken)  viewNearestDoctors,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _ViewNearestDoctors():
return viewNearestDoctors(_that.latitude,_that.longitude,_that.authToken);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( double latitude,  double longitude,  String? authToken)?  viewNearestDoctors,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _ViewNearestDoctors() when viewNearestDoctors != null:
return viewNearestDoctors(_that.latitude,_that.longitude,_that.authToken);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements ListNearestDoctorsEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListNearestDoctorsEvent.started()';
}


}




/// @nodoc


class _ViewNearestDoctors implements ListNearestDoctorsEvent {
  const _ViewNearestDoctors({required this.latitude, required this.longitude, this.authToken});
  

 final  double latitude;
 final  double longitude;
 final  String? authToken;

/// Create a copy of ListNearestDoctorsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ViewNearestDoctorsCopyWith<_ViewNearestDoctors> get copyWith => __$ViewNearestDoctorsCopyWithImpl<_ViewNearestDoctors>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ViewNearestDoctors&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.authToken, authToken) || other.authToken == authToken));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,authToken);

@override
String toString() {
  return 'ListNearestDoctorsEvent.viewNearestDoctors(latitude: $latitude, longitude: $longitude, authToken: $authToken)';
}


}

/// @nodoc
abstract mixin class _$ViewNearestDoctorsCopyWith<$Res> implements $ListNearestDoctorsEventCopyWith<$Res> {
  factory _$ViewNearestDoctorsCopyWith(_ViewNearestDoctors value, $Res Function(_ViewNearestDoctors) _then) = __$ViewNearestDoctorsCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, String? authToken
});




}
/// @nodoc
class __$ViewNearestDoctorsCopyWithImpl<$Res>
    implements _$ViewNearestDoctorsCopyWith<$Res> {
  __$ViewNearestDoctorsCopyWithImpl(this._self, this._then);

  final _ViewNearestDoctors _self;
  final $Res Function(_ViewNearestDoctors) _then;

/// Create a copy of ListNearestDoctorsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? authToken = freezed,}) {
  return _then(_ViewNearestDoctors(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,authToken: freezed == authToken ? _self.authToken : authToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ListNearestDoctorsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListNearestDoctorsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListNearestDoctorsState()';
}


}

/// @nodoc
class $ListNearestDoctorsStateCopyWith<$Res>  {
$ListNearestDoctorsStateCopyWith(ListNearestDoctorsState _, $Res Function(ListNearestDoctorsState) __);
}


/// Adds pattern-matching-related methods to [ListNearestDoctorsState].
extension ListNearestDoctorsStatePatterns on ListNearestDoctorsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Error():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( NearestDoctorsResponse response)?  success,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.response);case _Error() when error != null:
return error(_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( NearestDoctorsResponse response)  success,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.response);case _Error():
return error(_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( NearestDoctorsResponse response)?  success,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.response);case _Error() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ListNearestDoctorsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListNearestDoctorsState.initial()';
}


}




/// @nodoc


class _Loading implements ListNearestDoctorsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListNearestDoctorsState.loading()';
}


}




/// @nodoc


class _Success implements ListNearestDoctorsState {
  const _Success({required this.response});
  

 final  NearestDoctorsResponse response;

/// Create a copy of ListNearestDoctorsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'ListNearestDoctorsState.success(response: $response)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $ListNearestDoctorsStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 NearestDoctorsResponse response
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of ListNearestDoctorsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_Success(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as NearestDoctorsResponse,
  ));
}


}

/// @nodoc


class _Error implements ListNearestDoctorsState {
  const _Error({required this.error});
  

 final  String error;

/// Create a copy of ListNearestDoctorsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ListNearestDoctorsState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ListNearestDoctorsStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of ListNearestDoctorsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
