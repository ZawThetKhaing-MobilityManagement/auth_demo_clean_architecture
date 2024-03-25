import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/location_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/repository/location_repository.dart';

class GetCurrentLocationUsecase
    implements UsecaseWithParams<LocationEntity, LocationParams> {
  const GetCurrentLocationUsecase({required this.locationRepository});

  final LocationRepository locationRepository;

  @override
  ResultFuture<LocationEntity> call(LocationParams params) =>
      locationRepository.getCurrentLocation(params: params);
}

class LocationParams {
  LocationParams({
    required this.lat,
    required this.lon,
    required this.token,
    required this.status,
    required this.id,
    this.dealerId,
    this.clockIn,
    this.clockOut,
  });
  final double lat;
  final double lon;
  final String token;
  final String status;
  final DateTime? clockIn;
  final DateTime? clockOut;
  final int id;
  final int? dealerId;
}
