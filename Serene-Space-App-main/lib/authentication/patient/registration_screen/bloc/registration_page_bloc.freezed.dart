// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_page_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegistrationPageEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationPageEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationPageEvent()';
}


}

/// @nodoc
class $RegistrationPageEventCopyWith<$Res>  {
$RegistrationPageEventCopyWith(RegistrationPageEvent _, $Res Function(RegistrationPageEvent) __);
}


/// Adds pattern-matching-related methods to [RegistrationPageEvent].
extension RegistrationPageEventPatterns on RegistrationPageEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _PatientRegistration value)?  patientRegistration,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PatientRegistration() when patientRegistration != null:
return patientRegistration(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _PatientRegistration value)  patientRegistration,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _PatientRegistration():
return patientRegistration(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _PatientRegistration value)?  patientRegistration,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PatientRegistration() when patientRegistration != null:
return patientRegistration(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String name,  String password,  String email,  int phone,  String address,  String place,  int age,  String role,  double latitude,  double longitude)?  patientRegistration,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _PatientRegistration() when patientRegistration != null:
return patientRegistration(_that.name,_that.password,_that.email,_that.phone,_that.address,_that.place,_that.age,_that.role,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String name,  String password,  String email,  int phone,  String address,  String place,  int age,  String role,  double latitude,  double longitude)  patientRegistration,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _PatientRegistration():
return patientRegistration(_that.name,_that.password,_that.email,_that.phone,_that.address,_that.place,_that.age,_that.role,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String name,  String password,  String email,  int phone,  String address,  String place,  int age,  String role,  double latitude,  double longitude)?  patientRegistration,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _PatientRegistration() when patientRegistration != null:
return patientRegistration(_that.name,_that.password,_that.email,_that.phone,_that.address,_that.place,_that.age,_that.role,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements RegistrationPageEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationPageEvent.started()';
}


}




/// @nodoc


class _PatientRegistration implements RegistrationPageEvent {
  const _PatientRegistration({required this.name, required this.password, required this.email, required this.phone, required this.address, required this.place, required this.age, required this.role, required this.latitude, required this.longitude});
  

 final  String name;
 final  String password;
 final  String email;
 final  int phone;
 final  String address;
 final  String place;
 final  int age;
 final  String role;
 final  double latitude;
 final  double longitude;

/// Create a copy of RegistrationPageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientRegistrationCopyWith<_PatientRegistration> get copyWith => __$PatientRegistrationCopyWithImpl<_PatientRegistration>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatientRegistration&&(identical(other.name, name) || other.name == name)&&(identical(other.password, password) || other.password == password)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.place, place) || other.place == place)&&(identical(other.age, age) || other.age == age)&&(identical(other.role, role) || other.role == role)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,name,password,email,phone,address,place,age,role,latitude,longitude);

@override
String toString() {
  return 'RegistrationPageEvent.patientRegistration(name: $name, password: $password, email: $email, phone: $phone, address: $address, place: $place, age: $age, role: $role, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$PatientRegistrationCopyWith<$Res> implements $RegistrationPageEventCopyWith<$Res> {
  factory _$PatientRegistrationCopyWith(_PatientRegistration value, $Res Function(_PatientRegistration) _then) = __$PatientRegistrationCopyWithImpl;
@useResult
$Res call({
 String name, String password, String email, int phone, String address, String place, int age, String role, double latitude, double longitude
});




}
/// @nodoc
class __$PatientRegistrationCopyWithImpl<$Res>
    implements _$PatientRegistrationCopyWith<$Res> {
  __$PatientRegistrationCopyWithImpl(this._self, this._then);

  final _PatientRegistration _self;
  final $Res Function(_PatientRegistration) _then;

/// Create a copy of RegistrationPageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? password = null,Object? email = null,Object? phone = null,Object? address = null,Object? place = null,Object? age = null,Object? role = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_PatientRegistration(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$RegistrationPageState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationPageState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationPageState()';
}


}

/// @nodoc
class $RegistrationPageStateCopyWith<$Res>  {
$RegistrationPageStateCopyWith(RegistrationPageState _, $Res Function(RegistrationPageState) __);
}


/// Adds pattern-matching-related methods to [RegistrationPageState].
extension RegistrationPageStatePatterns on RegistrationPageState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( PatientRegistrationModel response)?  success,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( PatientRegistrationModel response)  success,required TResult Function( String error)  error,}) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( PatientRegistrationModel response)?  success,TResult? Function( String error)?  error,}) {final _that = this;
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


class _Initial implements RegistrationPageState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationPageState.initial()';
}


}




/// @nodoc


class _Loading implements RegistrationPageState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationPageState.loading()';
}


}




/// @nodoc


class _Success implements RegistrationPageState {
  const _Success({required this.response});
  

 final  PatientRegistrationModel response;

/// Create a copy of RegistrationPageState
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
  return 'RegistrationPageState.success(response: $response)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $RegistrationPageStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 PatientRegistrationModel response
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of RegistrationPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_Success(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as PatientRegistrationModel,
  ));
}


}

/// @nodoc


class _Error implements RegistrationPageState {
  const _Error({required this.error});
  

 final  String error;

/// Create a copy of RegistrationPageState
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
  return 'RegistrationPageState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $RegistrationPageStateCopyWith<$Res> {
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

/// Create a copy of RegistrationPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
