import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.lat,
    required super.lon,
  });

  factory LocationModel.fromJson(DataMap json) => LocationModel(
        lat: json['lat'],
        lon: json['lon'],
      );

  DataMap toJson() => {
        'lat': lat.toString(),
        'lon': lon.toString(),
      };

  LocationEntity toEntity() => LocationEntity(
        lat: lat,
        lon: lon,
      );
}
