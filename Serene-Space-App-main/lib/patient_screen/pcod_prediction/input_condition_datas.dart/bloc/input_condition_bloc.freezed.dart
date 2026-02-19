// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_condition_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InputConditionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputConditionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InputConditionEvent()';
}


}

/// @nodoc
class $InputConditionEventCopyWith<$Res>  {
$InputConditionEventCopyWith(InputConditionEvent _, $Res Function(InputConditionEvent) __);
}


/// Adds pattern-matching-related methods to [InputConditionEvent].
extension InputConditionEventPatterns on InputConditionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _MentalHealthSubmit value)?  mentalHealthSubmit,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _MentalHealthSubmit() when mentalHealthSubmit != null:
return mentalHealthSubmit(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _MentalHealthSubmit value)  mentalHealthSubmit,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _MentalHealthSubmit():
return mentalHealthSubmit(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _MentalHealthSubmit value)?  mentalHealthSubmit,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _MentalHealthSubmit() when mentalHealthSubmit != null:
return mentalHealthSubmit(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( int userId,  Map<String, String> answers)?  mentalHealthSubmit,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _MentalHealthSubmit() when mentalHealthSubmit != null:
return mentalHealthSubmit(_that.userId,_that.answers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( int userId,  Map<String, String> answers)  mentalHealthSubmit,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _MentalHealthSubmit():
return mentalHealthSubmit(_that.userId,_that.answers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( int userId,  Map<String, String> answers)?  mentalHealthSubmit,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _MentalHealthSubmit() when mentalHealthSubmit != null:
return mentalHealthSubmit(_that.userId,_that.answers);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements InputConditionEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InputConditionEvent.started()';
}


}




/// @nodoc


class _MentalHealthSubmit implements InputConditionEvent {
  const _MentalHealthSubmit({required this.userId, required final  Map<String, String> answers}): _answers = answers;
  

 final  int userId;
 final  Map<String, String> _answers;
 Map<String, String> get answers {
  if (_answers is EqualUnmodifiableMapView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_answers);
}


/// Create a copy of InputConditionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentalHealthSubmitCopyWith<_MentalHealthSubmit> get copyWith => __$MentalHealthSubmitCopyWithImpl<_MentalHealthSubmit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentalHealthSubmit&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._answers, _answers));
}


@override
int get hashCode => Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(_answers));

@override
String toString() {
  return 'InputConditionEvent.mentalHealthSubmit(userId: $userId, answers: $answers)';
}


}

/// @nodoc
abstract mixin class _$MentalHealthSubmitCopyWith<$Res> implements $InputConditionEventCopyWith<$Res> {
  factory _$MentalHealthSubmitCopyWith(_MentalHealthSubmit value, $Res Function(_MentalHealthSubmit) _then) = __$MentalHealthSubmitCopyWithImpl;
@useResult
$Res call({
 int userId, Map<String, String> answers
});




}
/// @nodoc
class __$MentalHealthSubmitCopyWithImpl<$Res>
    implements _$MentalHealthSubmitCopyWith<$Res> {
  __$MentalHealthSubmitCopyWithImpl(this._self, this._then);

  final _MentalHealthSubmit _self;
  final $Res Function(_MentalHealthSubmit) _then;

/// Create a copy of InputConditionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? answers = null,}) {
  return _then(_MentalHealthSubmit(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

/// @nodoc
mixin _$InputConditionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputConditionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InputConditionState()';
}


}

/// @nodoc
class $InputConditionStateCopyWith<$Res>  {
$InputConditionStateCopyWith(InputConditionState _, $Res Function(InputConditionState) __);
}


/// Adds pattern-matching-related methods to [InputConditionState].
extension InputConditionStatePatterns on InputConditionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _loading value)?  loading,TResult Function( _success value)?  success,TResult Function( _error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _loading() when loading != null:
return loading(_that);case _success() when success != null:
return success(_that);case _error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _loading value)  loading,required TResult Function( _success value)  success,required TResult Function( _error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _loading():
return loading(_that);case _success():
return success(_that);case _error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _loading value)?  loading,TResult? Function( _success value)?  success,TResult? Function( _error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _loading() when loading != null:
return loading(_that);case _success() when success != null:
return success(_that);case _error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( MentalHealthResponse response)?  success,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _loading() when loading != null:
return loading();case _success() when success != null:
return success(_that.response);case _error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( MentalHealthResponse response)  success,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _loading():
return loading();case _success():
return success(_that.response);case _error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( MentalHealthResponse response)?  success,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _loading() when loading != null:
return loading();case _success() when success != null:
return success(_that.response);case _error() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements InputConditionState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InputConditionState.initial()';
}


}




/// @nodoc


class _loading implements InputConditionState {
  const _loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InputConditionState.loading()';
}


}




/// @nodoc


class _success implements InputConditionState {
  const _success({required this.response});
  

 final  MentalHealthResponse response;

/// Create a copy of InputConditionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$successCopyWith<_success> get copyWith => __$successCopyWithImpl<_success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _success&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'InputConditionState.success(response: $response)';
}


}

/// @nodoc
abstract mixin class _$successCopyWith<$Res> implements $InputConditionStateCopyWith<$Res> {
  factory _$successCopyWith(_success value, $Res Function(_success) _then) = __$successCopyWithImpl;
@useResult
$Res call({
 MentalHealthResponse response
});




}
/// @nodoc
class __$successCopyWithImpl<$Res>
    implements _$successCopyWith<$Res> {
  __$successCopyWithImpl(this._self, this._then);

  final _success _self;
  final $Res Function(_success) _then;

/// Create a copy of InputConditionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_success(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as MentalHealthResponse,
  ));
}


}

/// @nodoc


class _error implements InputConditionState {
  const _error({required this.error});
  

 final  String error;

/// Create a copy of InputConditionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$errorCopyWith<_error> get copyWith => __$errorCopyWithImpl<_error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _error&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'InputConditionState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$errorCopyWith<$Res> implements $InputConditionStateCopyWith<$Res> {
  factory _$errorCopyWith(_error value, $Res Function(_error) _then) = __$errorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class __$errorCopyWithImpl<$Res>
    implements _$errorCopyWith<$Res> {
  __$errorCopyWithImpl(this._self, this._then);

  final _error _self;
  final $Res Function(_error) _then;

/// Create a copy of InputConditionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_error(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
