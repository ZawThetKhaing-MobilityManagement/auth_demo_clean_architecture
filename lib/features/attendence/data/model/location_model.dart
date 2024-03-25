import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.lat,
    required super.lon,
    required super.status,
    super.clockIn,
    super.clockOut,
    super.hour,
    super.minute,
    super.id,
  });

  factory LocationModel.fromJson(DataMap json) {
    json = json['attendance'];

    return LocationModel(
      lat: double.tryParse(json['lat'] ?? '') ?? 0,
      lon: double.tryParse(json['lon'] ?? '') ?? 0,
      status: json['status'] ?? '',
      clockIn: DateTime.tryParse(json['check_in'] ?? '')?.toLocal(),
      clockOut: DateTime.tryParse(json['check_out'] ?? '')?.toLocal(),
      hour: json['hour'] ?? '',
      minute: json['minute'] ?? '',
      id: int.tryParse(json['id'].toString()) ?? 0,
    );
  }

  factory LocationModel.fromEntity(LocationEntity entity) => LocationModel(
        lat: entity.lat,
        lon: entity.lat,
        status: entity.status,
        clockIn: entity.clockIn,
        clockOut: entity.clockOut,
        hour: entity.hour,
        minute: entity.minute,
        id: entity.id,
      );

  LocationModel copyWith({
    double? lat,
    double? lon,
    DateTime? clockIn,
    DateTime? clockOut,
    String? status,
    String? hour,
    String? minute,
    int? id,
  }) =>
      LocationModel(
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        clockIn: clockIn ?? this.clockIn,
        clockOut: clockOut ?? this.clockOut,
        status: status ?? this.status,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        id: id ?? this.id,
      );

  DataMap toJson() => {
        'attendance': {
          'lat': lat.toString(),
          'lon': lon.toString(),
          'check_in': clockIn.toString(),
          'check_out': clockOut.toString(),
          'status': status,
          'hour': hour.toString(),
          'minute': minute.toString(),
          'id': id.toString(),
        }
      };

  LocationEntity toEntity() => LocationEntity(
        lat: lat,
        lon: lon,
        clockIn: clockIn,
        clockOut: clockOut,
        status: status,
        hour: hour,
        minute: minute,
        id: id,
      );
}
