part of 'register_bloc_bloc.dart';

@freezed
class DocRegisterBlocEvent with _$DocRegisterBlocEvent {
  const factory DocRegisterBlocEvent.started() = _Started;
  const factory DocRegisterBlocEvent.docuserRegister({
    // required String role,
    required String hospitalname,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String address,
    required String age,
    required String place,
    required double latitude,
    required double longitude,
    required String gender,
    required String qualification,
    required String experience,
    required String specialzation,
    required XFile profilePic, // Add profile picture file
    required XFile medicalCertificate,
    //required String _profileImage,
    // required String id
  }) = _DocUserRegister;
}
