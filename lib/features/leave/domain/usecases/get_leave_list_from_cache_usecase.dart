import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/leave/domain/entities/leave_entity.dart';
import 'package:demo_login_ui/features/leave/domain/repository/leave_request_repository.dart';

class GetLeaveListFromCacheUsecase
    implements UsecaseWithoutParams<LeaveResponseEntity> {
  const GetLeaveListFromCacheUsecase({required this.leaveRequestRepository});

  final LeaveRequestRepository leaveRequestRepository;

  @override
  ResultFuture<LeaveResponseEntity> call() =>
      leaveRequestRepository.getLeaveListFromCache();
}
