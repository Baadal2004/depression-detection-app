// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_bloc_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DocRegisterBlocEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocRegisterBlocEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocRegisterBlocEvent()';
}


}

/// @nodoc
class $DocRegisterBlocEventCopyWith<$Res>  {
$DocRegisterBlocEventCopyWith(DocRegisterBlocEvent _, $Res Function(DocRegisterBlocEvent) __);
}


/// Adds pattern-matching-related methods to [DocRegisterBlocEvent].
extension DocRegisterBlocEventPatterns on DocRegisterBlocEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _DocUserRegister value)?  docuserRegister,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _DocUserRegister() when docuserRegister != null:
return docuserRegister(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _DocUserRegister value)  docuserRegister,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _DocUserRegister():
return docuserRegister(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _DocUserRegister value)?  docuserRegister,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _DocUserRegister() when docuserRegister != null:
return docuserRegister(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String hospitalname,  String name,  String email,  String phone,  String password,  String address,  String age,  String place,  double latitude,  double longitude,  String gender,  String qualification,  String experience,  String specialzation,  XFile profilePic,  XFile medicalCertificate)?  docuserRegister,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _DocUserRegister() when docuserRegister != null:
return docuserRegister(_that.hospitalname,_that.name,_that.email,_that.phone,_that.password,_that.address,_that.age,_that.place,_that.latitude,_that.longitude,_that.gender,_that.qualification,_that.experience,_that.specialzation,_that.profilePic,_that.medicalCertificate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String hospitalname,  String name,  String email,  String phone,  String password,  String address,  String age,  String place,  double latitude,  double longitude,  String gender,  String qualification,  String experience,  String specialzation,  XFile profilePic,  XFile medicalCertificate)  docuserRegister,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _DocUserRegister():
return docuserRegister(_that.hospitalname,_that.name,_that.email,_that.phone,_that.password,_that.address,_that.age,_that.place,_that.latitude,_that.longitude,_that.gender,_that.qualification,_that.experience,_that.specialzation,_that.profilePic,_that.medicalCertificate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String hospitalname,  String name,  String email,  String phone,  String password,  String address,  String age,  String place,  double latitude,  double longitude,  String gender,  String qualification,  String experience,  String specialzation,  XFile profilePic,  XFile medicalCertificate)?  docuserRegister,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _DocUserRegister() when docuserRegister != null:
return docuserRegister(_that.hospitalname,_that.name,_that.email,_that.phone,_that.password,_that.address,_that.age,_that.place,_that.latitude,_that.longitude,_that.gender,_that.qualification,_that.experience,_that.specialzation,_that.profilePic,_that.medicalCertificate);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements DocRegisterBlocEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocRegisterBlocEvent.started()';
}


}




/// @nodoc


class _DocUserRegister implements DocRegisterBlocEvent {
  const _DocUserRegister({required this.hospitalname, required this.name, required this.email, required this.phone, required this.password, required this.address, required this.age, required this.place, required this.latitude, required this.longitude, required this.gender, required this.qualification, required this.experience, required this.specialzation, required this.profilePic, required this.medicalCertificate});
  

// required String role,
 final  String hospitalname;
 final  String name;
 final  String email;
 final  String phone;
 final  String password;
 final  String address;
 final  String age;
 final  String place;
 final  double latitude;
 final  double longitude;
 final  String gender;
 final  String qualification;
 final  String experience;
 final  String specialzation;
 final  XFile profilePic;
// Add profile picture file
 final  XFile medicalCertificate;

/// Create a copy of DocRegisterBlocEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocUserRegisterCopyWith<_DocUserRegister> get copyWith => __$DocUserRegisterCopyWithImpl<_DocUserRegister>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocUserRegister&&(identical(other.hospitalname, hospitalname) || other.hospitalname == hospitalname)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.password, password) || other.password == password)&&(identical(other.address, address) || other.address == address)&&(identical(other.age, age) || other.age == age)&&(identical(other.place, place) || other.place == place)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.qualification, qualification) || other.qualification == qualification)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.specialzation, specialzation) || other.specialzation == specialzation)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.medicalCertificate, medicalCertificate) || other.medicalCertificate == medicalCertificate));
}


@override
int get hashCode => Object.hash(runtimeType,hospitalname,name,email,phone,password,address,age,place,latitude,longitude,gender,qualification,experience,specialzation,profilePic,medicalCertificate);

@override
String toString() {
  return 'DocRegisterBlocEvent.docuserRegister(hospitalname: $hospitalname, name: $name, email: $email, phone: $phone, password: $password, address: $address, age: $age, place: $place, latitude: $latitude, longitude: $longitude, gender: $gender, qualification: $qualification, experience: $experience, specialzation: $specialzation, profilePic: $profilePic, medicalCertificate: $medicalCertificate)';
}


}

/// @nodoc
abstract mixin class _$DocUserRegisterCopyWith<$Res> implements $DocRegisterBlocEventCopyWith<$Res> {
  factory _$DocUserRegisterCopyWith(_DocUserRegister value, $Res Function(_DocUserRegister) _then) = __$DocUserRegisterCopyWithImpl;
@useResult
$Res call({
 String hospitalname, String name, String email, String phone, String password, String address, String age, String place, double latitude, double longitude, String gender, String qualification, String experience, String specialzation, XFile profilePic, XFile medicalCertificate
});




}
/// @nodoc
class __$DocUserRegisterCopyWithImpl<$Res>
    implements _$DocUserRegisterCopyWith<$Res> {
  __$DocUserRegisterCopyWithImpl(this._self, this._then);

  final _DocUserRegister _self;
  final $Res Function(_DocUserRegister) _then;

/// Create a copy of DocRegisterBlocEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? hospitalname = null,Object? name = null,Object? email = null,Object? phone = null,Object? password = null,Object? address = null,Object? age = null,Object? place = null,Object? latitude = null,Object? longitude = null,Object? gender = null,Object? qualification = null,Object? experience = null,Object? specialzation = null,Object? profilePic = null,Object? medicalCertificate = null,}) {
  return _then(_DocUserRegister(
hospitalname: null == hospitalname ? _self.hospitalname : hospitalname // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as String,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,qualification: null == qualification ? _self.qualification : qualification // ignore: cast_nullable_to_non_nullable
as String,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String,specialzation: null == specialzation ? _self.specialzation : specialzation // ignore: cast_nullable_to_non_nullable
as String,profilePic: null == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as XFile,medicalCertificate: null == medicalCertificate ? _self.medicalCertificate : medicalCertificate // ignore: cast_nullable_to_non_nullable
as XFile,
  ));
}


}

/// @nodoc
mixin _$DocRegisterBlocState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocRegisterBlocState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocRegisterBlocState()';
}


}

/// @nodoc
class $DocRegisterBlocStateCopyWith<$Res>  {
$DocRegisterBlocStateCopyWith(DocRegisterBlocState _, $Res Function(DocRegisterBlocState) __);
}


/// Adds pattern-matching-related methods to [DocRegisterBlocState].
extension DocRegisterBlocStatePatterns on DocRegisterBlocState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( HospitalRegModel response)?  success,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( HospitalRegModel response)  success,required TResult Function( String error)  error,}) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( HospitalRegModel response)?  success,TResult? Function( String error)?  error,}) {final _that = this;
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


class _Initial implements DocRegisterBlocState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocRegisterBlocState.initial()';
}


}




/// @nodoc


class _Loading implements DocRegisterBlocState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocRegisterBlocState.loading()';
}


}




/// @nodoc


class _Success implements DocRegisterBlocState {
  const _Success({required this.response});
  

 final  HospitalRegModel response;

/// Create a copy of DocRegisterBlocState
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
  return 'DocRegisterBlocState.success(response: $response)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $DocRegisterBlocStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 HospitalRegModel response
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of DocRegisterBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_Success(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as HospitalRegModel,
  ));
}


}

/// @nodoc


class _Error implements DocRegisterBlocState {
  const _Error({required this.error});
  

 final  String error;

/// Create a copy of DocRegisterBlocState
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
  return 'DocRegisterBlocState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $DocRegisterBlocStateCopyWith<$Res> {
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

/// Create a copy of DocRegisterBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
