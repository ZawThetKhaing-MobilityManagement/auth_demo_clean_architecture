part of 'location_bloc.dart';

abstract class LocationState {
  const LocationState({this.model, this.message, this.dropDownChange});
  final LocationModel? model;
  final String? message;
  final String? dropDownChange;
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

class GetLocationFailedState extends LocationState {
  const GetLocationFailedState({required super.message, required super.model});
}

class DropDownChangeState extends LocationState {
  const DropDownChangeState(
      {required super.dropDownChange, required super.model});
}
