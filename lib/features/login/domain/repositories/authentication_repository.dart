import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/domain/entities/user_entity.dart';
import 'package:demo_login_ui/features/login/domain/usecases/login_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/signup_usecase.dart';

abstract class AuthenticationRepository {
  ResultFuture<UserEntity> signUp({
    required SignInParams params,
  });

  ResultFuture<UserEntity> login({
    required LoginInParams params,
  });

  ResultFuture<UserEntity?> authUser();

  ResultVoid logout();
}
