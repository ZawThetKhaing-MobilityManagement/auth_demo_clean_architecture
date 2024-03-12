import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/leave/domain/entities/leave_entity.dart';
import 'package:demo_login_ui/features/leave/domain/usecases/request_leave_usecase.dart';

abstract class LeaveRequestRepository {
  ResultVoid requestLeave(LeaveParams entity);
  ResultFuture<LeaveResponseEntity> getLeaveList(String token);
  ResultFuture<LeaveResponseEntity> getLeaveListFromCache();
}
