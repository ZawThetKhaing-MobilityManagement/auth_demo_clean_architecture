import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/leave/domain/repository/leave_request_repository.dart';

class LeaveRequestUsecase implements UsecaseWithParams<void, LeaveParams> {
  const LeaveRequestUsecase({required this.leaveRequestRepository});

  final LeaveRequestRepository leaveRequestRepository;

  @override
  ResultFuture<void> call(LeaveParams params) =>
      leaveRequestRepository.requestLeave(params);
}

class LeaveParams {
  const LeaveParams({
    required this.reason,
    required this.permissionType,
    required this.startDate,
    required this.token,
    required this.endDate,
  });
  final String reason;
  final String permissionType;
  final String token;
  final DateTime startDate;
  final DateTime endDate;
}
