import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/leave/data/datasource/local_data_source/leave_request_local_data_source.dart';
import 'package:demo_login_ui/features/leave/data/datasource/remote_data_source/leave_request_remote_data_source.dart';
import 'package:demo_login_ui/features/leave/data/model/leave_model.dart';
import 'package:demo_login_ui/features/leave/domain/entities/leave_entity.dart';
import 'package:demo_login_ui/features/leave/domain/repository/leave_request_repository.dart';
import 'package:demo_login_ui/features/leave/domain/usecases/request_leave_usecase.dart';

class LeaveRequestRepositoryImpl implements LeaveRequestRepository {
  LeaveRequestRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final LeaveRemoteDataSource remoteDataSource;
  final LeaveRequestLocalDataSource localDataSource;

  @override
  ResultFuture<LeaveResponseEntity> getLeaveList(String token) async {
    final result = await remoteDataSource.getLeaveList(token);
    return result.fold(
      (l) => Left(l),
      (responseEntity) {
        localDataSource
            .setCached(LeaveResponseModel.fromEntity(responseEntity));
        return Right(responseEntity);
      },
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

  @override
  ResultFuture<LeaveResponseEntity> getLeaveListFromCache() async {
    final result = await localDataSource.getCached();
    return result.fold((l) => Left(l), (responseModel) => Right(responseModel));
  }
}
