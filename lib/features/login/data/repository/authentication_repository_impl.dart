import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/data/datasource/localDataSource/user_local_data_source.dart';
import 'package:demo_login_ui/features/login/data/datasource/remoteDataSource/user_remote_data_source.dart';
import 'package:demo_login_ui/features/login/domain/entities/user_entity.dart';
import 'package:demo_login_ui/features/login/domain/repositories/authentication_repository.dart';
import 'package:demo_login_ui/features/login/domain/usecases/change_password_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/login_usecase.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSoure;

  AuthenticationRepositoryImpl({
    required this.userRemoteDataSource,
    required this.userLocalDataSoure,
  });

  @override
  ResultFuture<UserEntity> login({required LoginInParams params}) async {
    final result = await userRemoteDataSource.login(params);

    return result.fold(
      (faliure) {
        return Left(ServerFaliure(messages: faliure.messages));
      },
      (userModel) {
        userLocalDataSoure.setCached(userModel);

        return Right(userModel);
      },
    );
  }

  @override
  ResultFuture<UserEntity?> authUser() async {
    final result = await userLocalDataSoure.getCached();

    return result.fold(
      (l) => const Left(CacheFaliure(messages: 'No Data')),
      (userModel) => Right(userModel),
    );
  }

  @override
  ResultVoid logout() async {
    final model = await userLocalDataSoure.getCached();
    model.fold((l) => null, (r) {
      userRemoteDataSource.logout(r.token ?? "");
    });
    return userLocalDataSoure.removeCached();
  }

  @override
  ResultVoid changePassword(ChangePasswordParams params) =>
      userRemoteDataSource.changePassword(params);
}
