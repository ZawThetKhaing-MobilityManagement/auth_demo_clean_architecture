import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/attendence_list_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/location_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/usecases/get_current_location_usecase.dart';

abstract class LocationRepository {
  ResultFuture<LocationEntity> getCurrentLocation({
    required LocationParams params,
  });

  ResultFuture<LocationEntity> getLocationFromCache();
  ResultFuture<AttendenceListEntity> getAttendenceActivity(String token);
  ResultFuture<AttendenceListEntity> getAttendenceActivityFromCache();
}
