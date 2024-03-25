import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/domain/repositories/authentication_repository.dart';
import 'package:demo_login_ui/features/login/domain/usecases/login_usecase.dart';

class ChangePasswordUsecase
    implements UsecaseWithParams<void, ChangePasswordParams> {
  const ChangePasswordUsecase({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  @override
  ResultFuture<void> call(ChangePasswordParams params) =>
      authenticationRepository.changePassword(params);
}

class ChangePasswordParams {
  ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
    this.token,
  });

  final String currentPassword;
  final String newPassword;
  final String? token;
  ChangePasswordParams copyWith({
    String? currentPassword,
    String? newPassword,
    String? token,
  }) =>
      ChangePasswordParams(
        currentPassword: currentPassword ?? this.currentPassword,
        newPassword: newPassword ?? this.newPassword,
        token: token ?? this.token,
      );
}
