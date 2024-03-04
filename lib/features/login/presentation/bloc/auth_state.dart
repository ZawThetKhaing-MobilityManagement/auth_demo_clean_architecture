part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthblocInitial extends AuthState {}

class ProcessingState extends AuthState {}

class FaliureState extends AuthState {}

class AuthenticatedState extends AuthState {
  const AuthenticatedState({required this.userModel});

  final UserModel userModel;
}

class UnAuthenticatedState extends AuthState {}
