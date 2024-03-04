import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/domain/entities/user_entity.dart';
import 'package:demo_login_ui/features/login/domain/repositories/authentication_repository.dart';

class LoginUsecase implements UsecaseWithParams<UserEntity, LoginInParams> {
  final AuthenticationRepository authenticationRepository;

  LoginUsecase({required this.authenticationRepository});
  @override
  ResultFuture<UserEntity> call(LoginInParams params) =>
      authenticationRepository.login(params: params);
}

class LoginInParams {
  LoginInParams({required this.email, required this.password});

  final String email;
  final String password;
}
