import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/domain/entities/user_entity.dart';
import 'package:demo_login_ui/features/login/domain/repositories/authentication_repository.dart';

class AuthUserUsecase implements UsecaseWithoutParams<UserEntity?> {
  final AuthenticationRepository authenticationRepository;

  AuthUserUsecase({required this.authenticationRepository});

  @override
  ResultFuture<UserEntity?> call() {
    return authenticationRepository.authUser();
  }
}
