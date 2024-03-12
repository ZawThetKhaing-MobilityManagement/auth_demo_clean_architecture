import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/domain/entities/user_entity.dart';
import 'package:demo_login_ui/features/login/domain/repositories/authentication_repository.dart';

class SignUpUsecase extends UsecaseWithParams<UserEntity, SignInParams> {
  const SignUpUsecase({required this.authenticationRepository});
  final AuthenticationRepository authenticationRepository;

  @override
  ResultFuture<UserEntity> call(SignInParams params) async {
    try {
      return await authenticationRepository.signUp(params: params);
    } on ArgumentError catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}

class SignInParams {
  SignInParams(
      {required this.email, required this.name, required this.password});

  final String email;
  final String name;
  final String password;
}
