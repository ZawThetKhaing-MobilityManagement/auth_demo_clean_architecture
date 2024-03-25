part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState({
    this.message,
    this.userModel,
  });
  final String? message;

  final UserModel? userModel;

  @override
  List<Object?> get props => [userModel];
}

class AuthblocInitial extends AuthState {}

class ProcessingState extends AuthState {
  const ProcessingState({super.userModel});
}

class PasswordChangedState extends AuthState {
  const PasswordChangedState({super.message, super.userModel});
}

class FaliureState extends AuthState {
  const FaliureState({
    super.message,
    super.userModel,
  });
}

class AuthenticatedState extends AuthState {
  const AuthenticatedState({super.userModel});
}

class UnAuthenticatedState extends AuthState {}
