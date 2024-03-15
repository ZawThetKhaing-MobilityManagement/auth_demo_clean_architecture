import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/domain/entities/attendence_list_entity.dart';
import 'package:demo_login_ui/features/get_location/domain/repository/location_repository.dart';

class GetAttendenceActivityFromCacheUsecase
    implements UsecaseWithoutParams<AttendenceListEntity> {
  GetAttendenceActivityFromCacheUsecase({required this.locationRepository});

  final LocationRepository locationRepository;

  @override
  ResultFuture<AttendenceListEntity> call() =>
      locationRepository.getAttendenceActivityFromCache();
}
