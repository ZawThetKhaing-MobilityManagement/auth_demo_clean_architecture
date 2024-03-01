import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/domain/entities/user_entity.dart';

abstract class AuthenticationRepository {
  ResultFuture<UserEntity> signUp({
    required SignInParams params,
  });

  ResultFuture<UserEntity?> authUser();

  ResultVoid logout();
}
