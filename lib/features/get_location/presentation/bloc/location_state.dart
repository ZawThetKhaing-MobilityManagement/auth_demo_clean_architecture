part of 'location_bloc.dart';

abstract class LocationState {
  const LocationState();
}

class LocationInitial extends LocationState {}

class LocationGetSuccessfulState extends LocationState {
  const LocationGetSuccessfulState({required this.model});
  final LocationModel model;
}

class LocationLoadingState extends LocationState {}

class TimerState extends LocationState {
  const TimerState({required this.model});
  final LocationModel model;
}

class LocationGetFailedState extends LocationState {
  const LocationGetFailedState({required this.message});
  final String message;
}

class ClockInState extends LocationState {
  const ClockInState({required this.clockInTime});
  final DateTime clockInTime;
}
