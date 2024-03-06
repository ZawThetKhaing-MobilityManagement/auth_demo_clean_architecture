part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetLocationEvent extends LocationEvent {
  const GetLocationEvent({required this.token});

  final String token;
}

class GetLocationFailedEvent extends LocationEvent {}
