import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/attendence_list_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/repository/location_repository.dart';

class GetAttendenceActivityUsecase
    implements UsecaseWithParams<AttendenceListEntity, String> {
  const GetAttendenceActivityUsecase({required this.locationRepository});

  final LocationRepository locationRepository;

  @override
  ResultFuture<AttendenceListEntity> call(String params) =>
      locationRepository.getAttendenceActivity(params);
}
