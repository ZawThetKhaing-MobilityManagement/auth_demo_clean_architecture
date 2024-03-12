part of 'location_bloc.dart';

abstract class LocationState {
  const LocationState({
    this.model,
    this.message,
  });
  final LocationModel? model;
  final String? message;
}

class LocationInitial extends LocationState {}

class LocationGetSuccessfulState extends LocationState {
  const LocationGetSuccessfulState({required super.model});
}

class LoactionGetProcessingState extends LocationState {
  const LoactionGetProcessingState({super.model});
}

class TimerState extends LocationState {
  const TimerState({required super.model});
}

class LocationGetFailedState extends LocationState {
  const LocationGetFailedState({required super.message});
}
