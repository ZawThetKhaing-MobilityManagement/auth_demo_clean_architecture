part of 'location_bloc.dart';

enum Status { clockIn, clockOut }

abstract class LocationEvent extends Equatable {
  const LocationEvent({
    this.token,
    this.status,
    this.clockIn,
    this.message,
    this.model,
    this.dropDownValue,
    this.dealerId,
  });

  final String? token;
  final Status? status;
  final DateTime? clockIn;
  final String? message;
  final LocationModel? model;
  final String? dropDownValue;
  final int? dealerId;

  @override
  List<Object?> get props => [
        token,
        status,
        clockIn,
        message,
        model,
        dropDownValue,
        dealerId,
      ];
}

class GetLocationEvent extends LocationEvent {
  const GetLocationEvent({
    super.token,
    super.status,
    super.clockIn,
    super.dealerId,
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

class DropDownChangeEvent extends LocationEvent {
  const DropDownChangeEvent({super.dropDownValue});
}
