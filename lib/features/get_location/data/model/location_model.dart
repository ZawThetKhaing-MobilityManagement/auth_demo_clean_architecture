import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.lat,
    required super.lon,
    required super.status,
    super.clockIn,
    super.clockOut,
    super.hour,
    super.minute,
  });

  factory LocationModel.fromJson(DataMap json) => LocationModel(
        lat: double.parse(json['lat']),
        lon: double.parse(json['lon']),
        status: json['status'] ?? '',
        clockIn: DateTime.tryParse(json['clockIn'].toString()),
        clockOut: DateTime.tryParse(json['clockOut'].toString()),
        hour: json['hour'],
        minute: json['minute'],
      );

  factory LocationModel.fromEntity(LocationEntity entity) => LocationModel(
        lat: entity.lat,
        lon: entity.lat,
        status: entity.status,
        clockIn: entity.clockIn,
        clockOut: entity.clockOut,
        hour: entity.hour,
        minute: entity.minute,
      );

  LocationModel copyWith({
    double? lat,
    double? lon,
    DateTime? clockIn,
    DateTime? clockOut,
    String? status,
    String? hour,
    String? minute,
  }) =>
      LocationModel(
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        clockIn: clockIn ?? this.clockIn,
        clockOut: clockOut ?? this.clockOut,
        status: status ?? this.status,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
      );

  DataMap toJson() => {
        'lat': lat.toString(),
        'lon': lon.toString(),
        'clockIn': clockIn.toString(),
        'clockOut': clockOut.toString(),
        'status': status,
        'hour': hour.toString(),
        'minute': minute.toString(),
      };

  LocationEntity toEntity() => LocationEntity(
        lat: lat,
        lon: lon,
        clockIn: clockIn,
        clockOut: clockOut,
        status: status,
        hour: hour,
        minute: minute,
      );
}
