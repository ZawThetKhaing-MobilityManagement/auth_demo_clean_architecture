part of 'authbloc_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  const SignInEvent({required this.params});
  final SignInParams params;
}

class ProcessingEvent extends AuthEvent {}

class SuccessfulEvent extends AuthEvent {}

class UnAuthenticatedEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class AuthenticatedEvent extends AuthEvent {
  const AuthenticatedEvent({required this.userModel});

  final UserModel userModel;
}
