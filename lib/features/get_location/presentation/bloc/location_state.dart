part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationGetSuccessfulState extends LocationState {}

class LocationGetFailedState extends LocationState {
  const LocationGetFailedState({required this.message});
  final String message;
}
