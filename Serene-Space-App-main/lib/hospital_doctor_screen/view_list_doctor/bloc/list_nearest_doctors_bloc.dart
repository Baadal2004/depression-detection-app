// ...existing code...
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serene_space_project/hospital_doctor_screen/view_list_doctor/list_nearest_doctors_service.dart';

import '../list_nearest_doctors_model.dart'; // updated import to your model file

part 'list_nearest_doctors_event.dart';
part 'list_nearest_doctors_state.dart';
part 'list_nearest_doctors_bloc.freezed.dart';

class ListNearestDoctorsBloc extends Bloc<ListNearestDoctorsEvent, ListNearestDoctorsState> {
  final DoctorService doctorService;

  ListNearestDoctorsBloc({required this.doctorService})
      : super(const ListNearestDoctorsState.initial()) {
    on<_Started>(_onStarted);
    on<_ViewNearestDoctors>(_onViewNearestDoctors);
  }

  FutureOr<void> _onStarted(_Started event, Emitter<ListNearestDoctorsState> emit) {
    emit(const ListNearestDoctorsState.initial());
  }

  Future<void> _onViewNearestDoctors(_ViewNearestDoctors event, Emitter<ListNearestDoctorsState> emit) async {
    emit(const ListNearestDoctorsState.loading());
    try {
      final NearestDoctorsResponse resp = await doctorService.fetchNearestDoctors(
        latitude: event.latitude,
        longitude: event.longitude,
       // authToken: event.authToken,
      );
      emit(ListNearestDoctorsState.success(response: resp));
    } catch (e) {
      emit(ListNearestDoctorsState.error(error: e.toString()));
    }
  }
}