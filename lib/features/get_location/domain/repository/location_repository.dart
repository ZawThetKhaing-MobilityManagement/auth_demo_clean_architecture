import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/domain/entities/location_entity.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_current_location_usecase.dart';

abstract class LocationRepository {
  ResultFuture<LocationEntity> getCurrentLocation({
    required LocationParams params,
  });
}
