// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_cycle_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InputCycleEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputCycleEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InputCycleEvent()';
}


}

/// @nodoc
class $InputCycleEventCopyWith<$Res>  {
$InputCycleEventCopyWith(InputCycleEvent _, $Res Function(InputCycleEvent) __);
}


/// Adds pattern-matching-related methods to [InputCycleEvent].
extension InputCycleEventPatterns on InputCycleEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _PredictADHD value)?  predictADHD,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PredictADHD() when predictADHD != null:
return predictADHD(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _PredictADHD value)  predictADHD,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _PredictADHD():
return predictADHD(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _PredictADHD value)?  predictADHD,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PredictADHD() when predictADHD != null:
return predictADHD(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( int userId,  int age,  String gender,  double sleepingHour,  String distracted,  String forgetful,  String poorOrganization,  String sustainingAttention,  String restlessness,  String impulsivityScore,  double screenTime,  double phoneUnlocks,  double workingHour)?  predictADHD,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _PredictADHD() when predictADHD != null:
return predictADHD(_that.userId,_that.age,_that.gender,_that.sleepingHour,_that.distracted,_that.forgetful,_that.poorOrganization,_that.sustainingAttention,_that.restlessness,_that.impulsivityScore,_that.screenTime,_that.phoneUnlocks,_that.workingHour);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( int userId,  int age,  String gender,  double sleepingHour,  String distracted,  String forgetful,  String poorOrganization,  String sustainingAttention,  String restlessness,  String impulsivityScore,  double screenTime,  double phoneUnlocks,  double workingHour)  predictADHD,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _PredictADHD():
return predictADHD(_that.userId,_that.age,_that.gender,_that.sleepingHour,_that.distracted,_that.forgetful,_that.poorOrganization,_that.sustainingAttention,_that.restlessness,_that.impulsivityScore,_that.screenTime,_that.phoneUnlocks,_that.workingHour);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( int userId,  int age,  String gender,  double sleepingHour,  String distracted,  String forgetful,  String poorOrganization,  String sustainingAttention,  String restlessness,  String impulsivityScore,  double screenTime,  double phoneUnlocks,  double workingHour)?  predictADHD,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _PredictADHD() when predictADHD != null:
return predictADHD(_that.userId,_that.age,_that.gender,_that.sleepingHour,_that.distracted,_that.forgetful,_that.poorOrganization,_that.sustainingAttention,_that.restlessness,_that.impulsivityScore,_that.screenTime,_that.phoneUnlocks,_that.workingHour);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements InputCycleEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InputCycleEvent.started()';
}


}




/// @nodoc


class _PredictADHD implements InputCycleEvent {
  const _PredictADHD({required this.userId, required this.age, required this.gender, required this.sleepingHour, required this.distracted, required this.forgetful, required this.poorOrganization, required this.sustainingAttention, required this.restlessness, required this.impulsivityScore, required this.screenTime, required this.phoneUnlocks, required this.workingHour});
  

 final  int userId;
 final  int age;
 final  String gender;
 final  double sleepingHour;
 final  String distracted;
 final  String forgetful;
 final  String poorOrganization;
 final  String sustainingAttention;
 final  String restlessness;
 final  String impulsivityScore;
 final  double screenTime;
 final  double phoneUnlocks;
 final  double workingHour;

/// Create a copy of InputCycleEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PredictADHDCopyWith<_PredictADHD> get copyWith => __$PredictADHDCopyWithImpl<_PredictADHD>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PredictADHD&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.sleepingHour, sleepingHour) || other.sleepingHour == sleepingHour)&&(identical(other.distracted, distracted) || other.distracted == distracted)&&(identical(other.forgetful, forgetful) || other.forgetful == forgetful)&&(identical(other.poorOrganization, poorOrganization) || other.poorOrganization == poorOrganization)&&(identical(other.sustainingAttention, sustainingAttention) || other.sustainingAttention == sustainingAttention)&&(identical(other.restlessness, restlessness) || other.restlessness == restlessness)&&(identical(other.impulsivityScore, impulsivityScore) || other.impulsivityScore == impulsivityScore)&&(identical(other.screenTime, screenTime) || other.screenTime == screenTime)&&(identical(other.phoneUnlocks, phoneUnlocks) || other.phoneUnlocks == phoneUnlocks)&&(identical(other.workingHour, workingHour) || other.workingHour == workingHour));
}


@override
int get hashCode => Object.hash(runtimeType,userId,age,gender,sleepingHour,distracted,forgetful,poorOrganization,sustainingAttention,restlessness,impulsivityScore,screenTime,phoneUnlocks,workingHour);

@override
String toString() {
  return 'InputCycleEvent.predictADHD(userId: $userId, age: $age, gender: $gender, sleepingHour: $sleepingHour, distracted: $distracted, forgetful: $forgetful, poorOrganization: $poorOrganization, sustainingAttention: $sustainingAttention, restlessness: $restlessness, impulsivityScore: $impulsivityScore, screenTime: $screenTime, phoneUnlocks: $phoneUnlocks, workingHour: $workingHour)';
}


}

/// @nodoc
abstract mixin class _$PredictADHDCopyWith<$Res> implements $InputCycleEventCopyWith<$Res> {
  factory _$PredictADHDCopyWith(_PredictADHD value, $Res Function(_PredictADHD) _then) = __$PredictADHDCopyWithImpl;
@useResult
$Res call({
 int userId, int age, String gender, double sleepingHour, String distracted, String forgetful, String poorOrganization, String sustainingAttention, String restlessness, String impulsivityScore, double screenTime, double phoneUnlocks, double workingHour
});




}
/// @nodoc
class __$PredictADHDCopyWithImpl<$Res>
    implements _$PredictADHDCopyWith<$Res> {
  __$PredictADHDCopyWithImpl(this._self, this._then);

  final _PredictADHD _self;
  final $Res Function(_PredictADHD) _then;

/// Create a copy of InputCycleEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? age = null,Object? gender = null,Object? sleepingHour = null,Object? distracted = null,Object? forgetful = null,Object? poorOrganization = null,Object? sustainingAttention = null,Object? restlessness = null,Object? impulsivityScore = null,Object? screenTime = null,Object? phoneUnlocks = null,Object? workingHour = null,}) {
  return _then(_PredictADHD(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,sleepingHour: null == sleepingHour ? _self.sleepingHour : sleepingHour // ignore: cast_nullable_to_non_nullable
as double,distracted: null == distracted ? _self.distracted : distracted // ignore: cast_nullable_to_non_nullable
as String,forgetful: null == forgetful ? _self.forgetful : forgetful // ignore: cast_nullable_to_non_nullable
as String,poorOrganization: null == poorOrganization ? _self.poorOrganization : poorOrganization // ignore: cast_nullable_to_non_nullable
as String,sustainingAttention: null == sustainingAttention ? _self.sustainingAttention : sustainingAttention // ignore: cast_nullable_to_non_nullable
as String,restlessness: null == restlessness ? _self.restlessness : restlessness // ignore: cast_nullable_to_non_nullable
as String,impulsivityScore: null == impulsivityScore ? _self.impulsivityScore : impulsivityScore // ignore: cast_nullable_to_non_nullable
as String,screenTime: null == screenTime ? _self.screenTime : screenTime // ignore: cast_nullable_to_non_nullable
as double,phoneUnlocks: null == phoneUnlocks ? _self.phoneUnlocks : phoneUnlocks // ignore: cast_nullable_to_non_nullable
as double,workingHour: null == workingHour ? _self.workingHour : workingHour // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$InputCycleState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputCycleState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InputCycleState()';
}


}

/// @nodoc
class $InputCycleStateCopyWith<$Res>  {
$InputCycleStateCopyWith(InputCycleState _, $Res Function(InputCycleState) __);
}


/// Adds pattern-matching-related methods to [InputCycleState].
extension InputCycleStatePatterns on InputCycleState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( AdhdPredictionModel response)?  success,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( AdhdPredictionModel response)  success,required TResult Function( String error)  error,}) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( AdhdPredictionModel response)?  success,TResult? Function( String error)?  error,}) {final _that = this;
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


class _Initial implements InputCycleState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InputCycleState.initial()';
}


}




/// @nodoc


class _Loading implements InputCycleState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InputCycleState.loading()';
}


}




/// @nodoc


class _Success implements InputCycleState {
  const _Success({required this.response});
  

 final  AdhdPredictionModel response;

/// Create a copy of InputCycleState
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
  return 'InputCycleState.success(response: $response)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $InputCycleStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 AdhdPredictionModel response
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of InputCycleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_Success(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as AdhdPredictionModel,
  ));
}


}

/// @nodoc


class _Error implements InputCycleState {
  const _Error({required this.error});
  

 final  String error;

/// Create a copy of InputCycleState
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
  return 'InputCycleState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $InputCycleStateCopyWith<$Res> {
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

/// Create a copy of InputCycleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
