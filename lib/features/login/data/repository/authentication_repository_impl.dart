import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/data/datasource/localDataSource/user_local_data_source.dart';
import 'package:demo_login_ui/features/login/data/datasource/remoteDataSource/authentication_remote_data_source.dart';
import 'package:demo_login_ui/features/login/domain/entities/user_entity.dart';
import 'package:demo_login_ui/features/login/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSoure;

  AuthenticationRepositoryImpl({
    required this.userRemoteDataSource,
    required this.userLocalDataSoure,
  });

  @override
  ResultFuture<UserEntity> signUp({required SignInParams params}) async {
    final result =
        await userRemoteDataSource.signUpwithEmailandPassword(params);
    return result.fold(
      (faliure) => Left(ServerFaliure(messages: faliure.messages)),
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
  ResultVoid logout() => userLocalDataSoure.removeCached();
}
