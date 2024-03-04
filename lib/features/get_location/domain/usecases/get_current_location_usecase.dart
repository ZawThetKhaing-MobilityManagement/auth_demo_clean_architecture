import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/domain/entities/location_entity.dart';
import 'package:demo_login_ui/features/get_location/domain/repository/location_repository.dart';

class GetCurrentLocation
    implements UsecaseWithParams<LocationEntity, LocationParams> {
  const GetCurrentLocation({required this.locationRepository});

  final LocationRepository locationRepository;

  @override
  ResultFuture<LocationEntity> call(LocationParams params) =>
      locationRepository.getCurrentLocation(params: params);
}

class LocationParams {
  LocationParams({required this.lat, required, required this.lon});
  final double lat;
  final double lon;
}
