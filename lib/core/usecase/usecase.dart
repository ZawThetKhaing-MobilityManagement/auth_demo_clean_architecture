import 'package:demo_login_ui/core/utils/typedef.dart';

abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();
  ResultFuture<Type> call();
}

class SignInParams {
  SignInParams(
      {required this.email, required this.name, required this.password});

  final String email;
  final String name;
  final String password;
}
