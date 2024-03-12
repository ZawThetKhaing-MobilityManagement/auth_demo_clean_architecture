part of 'location_bloc.dart';

enum Status { clockIn, clockOut }

abstract class LocationEvent extends Equatable {
  const LocationEvent({
    this.token,
    this.status,
    this.clockIn,
    this.message,
    this.model,
  });

  final String? token;
  final Status? status;
  final DateTime? clockIn;
  final String? message;
  final LocationModel? model;

  @override
  List<Object?> get props => [
        token,
        status,
        clockIn,
        message,
        model,
      ];
}

class GetLocationEvent extends LocationEvent {
  const GetLocationEvent({
    super.token,
    super.status,
    super.clockIn,
  });
}

class GetLocationFailedEvent extends LocationEvent {
  const GetLocationFailedEvent({super.message});
}

class TimerEvent extends LocationEvent {
  const TimerEvent({super.model});
}

class LocationCacheEvent extends LocationEvent {
  const LocationCacheEvent({super.model});
}
