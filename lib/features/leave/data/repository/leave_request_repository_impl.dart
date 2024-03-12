import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/leave/data/datasource/remote_data_source/leave_request_remote_data_source.dart';
import 'package:demo_login_ui/features/leave/domain/entities/leave_entity.dart';
import 'package:demo_login_ui/features/leave/domain/repository/leave_request_repository.dart';
import 'package:demo_login_ui/features/leave/domain/usecases/request_leave_usecase.dart';

class LeaveRequestRepositoryImpl implements LeaveRequestRepository {
  LeaveRequestRepositoryImpl({required this.remoteDataSource});

  final LeaveRemoteDataSource remoteDataSource;

  @override
  ResultFuture<List<LeaveEntity>> getLeaveList(String token) async {
    final result = await remoteDataSource.getLeaveList(token);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  ResultVoid requestLeave(LeaveParams params) async {
    final result = await remoteDataSource.requestLeave(params);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
