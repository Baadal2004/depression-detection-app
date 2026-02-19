// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DoctorLoginEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorLoginEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorLoginEvent()';
}


}

/// @nodoc
class $DoctorLoginEventCopyWith<$Res>  {
$DoctorLoginEventCopyWith(DoctorLoginEvent _, $Res Function(DoctorLoginEvent) __);
}


/// Adds pattern-matching-related methods to [DoctorLoginEvent].
extension DoctorLoginEventPatterns on DoctorLoginEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _DocLogin value)?  docLogin,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _DocLogin() when docLogin != null:
return docLogin(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _DocLogin value)  docLogin,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _DocLogin():
return docLogin(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _DocLogin value)?  docLogin,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _DocLogin() when docLogin != null:
return docLogin(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String role,  String email,  String doctorId)?  docLogin,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _DocLogin() when docLogin != null:
return docLogin(_that.role,_that.email,_that.doctorId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String role,  String email,  String doctorId)  docLogin,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _DocLogin():
return docLogin(_that.role,_that.email,_that.doctorId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String role,  String email,  String doctorId)?  docLogin,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _DocLogin() when docLogin != null:
return docLogin(_that.role,_that.email,_that.doctorId);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements DoctorLoginEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorLoginEvent.started()';
}


}




/// @nodoc


class _DocLogin implements DoctorLoginEvent {
  const _DocLogin({required this.role, required this.email, required this.doctorId});
  

 final  String role;
 final  String email;
 final  String doctorId;

/// Create a copy of DoctorLoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocLoginCopyWith<_DocLogin> get copyWith => __$DocLoginCopyWithImpl<_DocLogin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocLogin&&(identical(other.role, role) || other.role == role)&&(identical(other.email, email) || other.email == email)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId));
}


@override
int get hashCode => Object.hash(runtimeType,role,email,doctorId);

@override
String toString() {
  return 'DoctorLoginEvent.docLogin(role: $role, email: $email, doctorId: $doctorId)';
}


}

/// @nodoc
abstract mixin class _$DocLoginCopyWith<$Res> implements $DoctorLoginEventCopyWith<$Res> {
  factory _$DocLoginCopyWith(_DocLogin value, $Res Function(_DocLogin) _then) = __$DocLoginCopyWithImpl;
@useResult
$Res call({
 String role, String email, String doctorId
});




}
/// @nodoc
class __$DocLoginCopyWithImpl<$Res>
    implements _$DocLoginCopyWith<$Res> {
  __$DocLoginCopyWithImpl(this._self, this._then);

  final _DocLogin _self;
  final $Res Function(_DocLogin) _then;

/// Create a copy of DoctorLoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? role = null,Object? email = null,Object? doctorId = null,}) {
  return _then(_DocLogin(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DoctorLoginState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorLoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorLoginState()';
}


}

/// @nodoc
class $DoctorLoginStateCopyWith<$Res>  {
$DoctorLoginStateCopyWith(DoctorLoginState _, $Res Function(DoctorLoginState) __);
}


/// Adds pattern-matching-related methods to [DoctorLoginState].
extension DoctorLoginStatePatterns on DoctorLoginState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( dynamic response)?  success,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( dynamic response)  success,required TResult Function( String error)  error,}) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( dynamic response)?  success,TResult? Function( String error)?  error,}) {final _that = this;
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


class _Initial implements DoctorLoginState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorLoginState.initial()';
}


}




/// @nodoc


class _Loading implements DoctorLoginState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorLoginState.loading()';
}


}




/// @nodoc


class _Success implements DoctorLoginState {
  const _Success({required this.response});
  

 final  dynamic response;

/// Create a copy of DoctorLoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&const DeepCollectionEquality().equals(other.response, response));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(response));

@override
String toString() {
  return 'DoctorLoginState.success(response: $response)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $DoctorLoginStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 dynamic response
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of DoctorLoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = freezed,}) {
  return _then(_Success(
response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class _Error implements DoctorLoginState {
  const _Error({required this.error});
  

 final  String error;

/// Create a copy of DoctorLoginState
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
  return 'DoctorLoginState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $DoctorLoginStateCopyWith<$Res> {
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

/// Create a copy of DoctorLoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
