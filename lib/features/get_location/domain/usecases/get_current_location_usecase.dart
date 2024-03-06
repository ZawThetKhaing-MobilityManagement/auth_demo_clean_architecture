import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/domain/repository/location_repository.dart';

class GetCurrentLocationUsecase
    implements UsecaseWithParams<String, LocationParams> {
  const GetCurrentLocationUsecase({required this.locationRepository});

  final LocationRepository locationRepository;

  @override
  ResultFuture<String> call(LocationParams params) =>
      locationRepository.getCurrentLocation(params: params);
}

class LocationParams {
  LocationParams({
    required this.lat,
    required,
    required this.lon,
    required this.token,
  });
  final double lat;
  final double lon;
  final String token;
}
