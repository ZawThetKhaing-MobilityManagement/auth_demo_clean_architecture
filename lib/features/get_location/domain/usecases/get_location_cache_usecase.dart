import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/domain/entities/location_entity.dart';
import 'package:demo_login_ui/features/get_location/domain/repository/location_repository.dart';

class GetLocationCacheUseCase implements UsecaseWithoutParams<LocationEntity> {
  GetLocationCacheUseCase({required this.locationRepository});

  final LocationRepository locationRepository;

  @override
  ResultFuture<LocationEntity> call() => locationRepository.getLocationFromCache();
}
