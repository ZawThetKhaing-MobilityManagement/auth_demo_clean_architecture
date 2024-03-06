import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_current_location_usecase.dart';

abstract class LocationRepository {
  ResultFuture<String> getCurrentLocation({
    required LocationParams params,
  });
}
