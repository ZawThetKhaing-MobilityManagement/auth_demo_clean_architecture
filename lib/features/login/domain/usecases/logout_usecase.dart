import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/domain/repositories/authentication_repository.dart';

class LogoutUsecase implements UsecaseWithoutParams<void> {
  final AuthenticationRepository authenticationRepository;

  LogoutUsecase({required this.authenticationRepository});
  @override
  ResultFuture<void> call() => authenticationRepository.logout();
}
