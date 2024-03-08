part of 'location_bloc.dart';

enum Status { clockIn, clockOut }

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetLocationEvent extends LocationEvent {
  const GetLocationEvent({
    required this.token,
    required this.status,
    this.clockIn,
  });

  final String token;
  final Status status;
  final DateTime? clockIn;
}

class GetLocationFailedEvent extends LocationEvent {
  const GetLocationFailedEvent({required this.message});

  final String message;
}

class TimerEvent extends LocationEvent {
  const TimerEvent({required this.model});

  final LocationModel model;
}

class LocationCacheEvent extends LocationEvent {
  const LocationCacheEvent({required this.entity});

  final LocationEntity entity;
}
