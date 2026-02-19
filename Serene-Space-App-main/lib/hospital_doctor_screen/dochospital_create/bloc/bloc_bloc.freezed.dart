// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bloc_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BlocEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlocEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BlocEvent()';
}


}

/// @nodoc
class $BlocEventCopyWith<$Res>  {
$BlocEventCopyWith(BlocEvent _, $Res Function(BlocEvent) __);
}


/// Adds pattern-matching-related methods to [BlocEvent].
extension BlocEventPatterns on BlocEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _UploadSlots value)?  uploadSlots,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _UploadSlots() when uploadSlots != null:
return uploadSlots(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _UploadSlots value)  uploadSlots,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _UploadSlots():
return uploadSlots(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _UploadSlots value)?  uploadSlots,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _UploadSlots() when uploadSlots != null:
return uploadSlots(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( int clinicDoctor,  String date,  String startTime,  String endTime,  List<String> timeslots)?  uploadSlots,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _UploadSlots() when uploadSlots != null:
return uploadSlots(_that.clinicDoctor,_that.date,_that.startTime,_that.endTime,_that.timeslots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( int clinicDoctor,  String date,  String startTime,  String endTime,  List<String> timeslots)  uploadSlots,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _UploadSlots():
return uploadSlots(_that.clinicDoctor,_that.date,_that.startTime,_that.endTime,_that.timeslots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( int clinicDoctor,  String date,  String startTime,  String endTime,  List<String> timeslots)?  uploadSlots,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _UploadSlots() when uploadSlots != null:
return uploadSlots(_that.clinicDoctor,_that.date,_that.startTime,_that.endTime,_that.timeslots);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements BlocEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BlocEvent.started()';
}


}




/// @nodoc


class _UploadSlots implements BlocEvent {
  const _UploadSlots({required this.clinicDoctor, required this.date, required this.startTime, required this.endTime, required final  List<String> timeslots}): _timeslots = timeslots;
  

 final  int clinicDoctor;
 final  String date;
 final  String startTime;
 final  String endTime;
 final  List<String> _timeslots;
 List<String> get timeslots {
  if (_timeslots is EqualUnmodifiableListView) return _timeslots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeslots);
}


/// Create a copy of BlocEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadSlotsCopyWith<_UploadSlots> get copyWith => __$UploadSlotsCopyWithImpl<_UploadSlots>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadSlots&&(identical(other.clinicDoctor, clinicDoctor) || other.clinicDoctor == clinicDoctor)&&(identical(other.date, date) || other.date == date)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other._timeslots, _timeslots));
}


@override
int get hashCode => Object.hash(runtimeType,clinicDoctor,date,startTime,endTime,const DeepCollectionEquality().hash(_timeslots));

@override
String toString() {
  return 'BlocEvent.uploadSlots(clinicDoctor: $clinicDoctor, date: $date, startTime: $startTime, endTime: $endTime, timeslots: $timeslots)';
}


}

/// @nodoc
abstract mixin class _$UploadSlotsCopyWith<$Res> implements $BlocEventCopyWith<$Res> {
  factory _$UploadSlotsCopyWith(_UploadSlots value, $Res Function(_UploadSlots) _then) = __$UploadSlotsCopyWithImpl;
@useResult
$Res call({
 int clinicDoctor, String date, String startTime, String endTime, List<String> timeslots
});




}
/// @nodoc
class __$UploadSlotsCopyWithImpl<$Res>
    implements _$UploadSlotsCopyWith<$Res> {
  __$UploadSlotsCopyWithImpl(this._self, this._then);

  final _UploadSlots _self;
  final $Res Function(_UploadSlots) _then;

/// Create a copy of BlocEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? clinicDoctor = null,Object? date = null,Object? startTime = null,Object? endTime = null,Object? timeslots = null,}) {
  return _then(_UploadSlots(
clinicDoctor: null == clinicDoctor ? _self.clinicDoctor : clinicDoctor // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,timeslots: null == timeslots ? _self._timeslots : timeslots // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$BlocState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlocState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BlocState()';
}


}

/// @nodoc
class $BlocStateCopyWith<$Res>  {
$BlocStateCopyWith(BlocState _, $Res Function(BlocState) __);
}


/// Adds pattern-matching-related methods to [BlocState].
extension BlocStatePatterns on BlocState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( HospitalDoctorSlotModel response)?  success,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( HospitalDoctorSlotModel response)  success,required TResult Function( String error)  error,}) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( HospitalDoctorSlotModel response)?  success,TResult? Function( String error)?  error,}) {final _that = this;
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


class _Initial implements BlocState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BlocState.initial()';
}


}




/// @nodoc


class _Loading implements BlocState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BlocState.loading()';
}


}




/// @nodoc


class _Success implements BlocState {
  const _Success({required this.response});
  

 final  HospitalDoctorSlotModel response;

/// Create a copy of BlocState
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
  return 'BlocState.success(response: $response)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $BlocStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 HospitalDoctorSlotModel response
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of BlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_Success(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as HospitalDoctorSlotModel,
  ));
}


}

/// @nodoc


class _Error implements BlocState {
  const _Error({required this.error});
  

 final  String error;

/// Create a copy of BlocState
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
  return 'BlocState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $BlocStateCopyWith<$Res> {
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

/// Create a copy of BlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
