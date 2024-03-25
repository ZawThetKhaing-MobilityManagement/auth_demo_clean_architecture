part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent({
    this.loginInParams,
    this.changePasswordParams,
    this.userModel,
  });
  final LoginInParams? loginInParams;
  final ChangePasswordParams? changePasswordParams;
  final UserModel? userModel;

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  const LoginEvent({required super.loginInParams});
}

class ChangePasswordEvent extends AuthEvent {
  const ChangePasswordEvent({required super.changePasswordParams});
}

class ProcessingEvent extends AuthEvent {}

class UnAuthenticatedEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class AuthenticatedEvent extends AuthEvent {
  const AuthenticatedEvent({super.userModel});
}
