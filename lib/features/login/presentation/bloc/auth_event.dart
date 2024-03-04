part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent({required this.params});
  final SignInParams params;
}

class LoginEvent extends AuthEvent {
  const LoginEvent({required this.params});
  final LoginInParams params;
}

class ProcessingEvent extends AuthEvent {}

class UnAuthenticatedEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class AuthenticatedEvent extends AuthEvent {
  const AuthenticatedEvent({required this.userModel});

  final UserModel userModel;
}
