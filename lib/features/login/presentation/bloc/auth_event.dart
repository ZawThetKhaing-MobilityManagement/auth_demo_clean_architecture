part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent({
    this.signUpParams,
    this.loginInParams,
    this.userModel,
  });
  final SignInParams? signUpParams;
  final LoginInParams? loginInParams;
  final UserModel? userModel;

  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent({required super.signUpParams});
}

class LoginEvent extends AuthEvent {
  const LoginEvent({required super.loginInParams});
}

class ProcessingEvent extends AuthEvent {}

class UnAuthenticatedEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class AuthenticatedEvent extends AuthEvent {
  const AuthenticatedEvent({super.userModel});
}
