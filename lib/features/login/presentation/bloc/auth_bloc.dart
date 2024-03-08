import 'dart:async';

import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/domain/usecases/login_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/auth_user_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/signup_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.authUserUsecase,
    required this.signUpUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
  }) : super(AuthblocInitial()) {
    on<SignUpEvent>(
      (event, emit) async {
        emit(ProcessingState());
        try {
          final result = await signUpUsecase(event.params);

          result.fold(
            (l) => emit(FaliureState(message: l.messages)),
            (r) => emit(
              AuthenticatedState(userModel: UserModel.fromEntity(r)),
            ),
          );
        } catch (e) {
          emit(const FaliureState(message: 'Something Went Wrong'));
        }
      },
    );

    on<LoginEvent>(
      (event, emit) async {
        emit(ProcessingState());
        try {
          final result = await loginUsecase(event.params);

          result.fold(
            (l) => emit(FaliureState(message: l.messages)),
            (r) => emit(
              AuthenticatedState(userModel: UserModel.fromEntity(r)),
            ),
          );
        } catch (e) {
          emit(const FaliureState(message: "Something Went Wrong"));
        }
      },
    );

    on<UnAuthenticatedEvent>((event, emit) => emit(UnAuthenticatedState()));

    on<AuthenticatedEvent>(
      (event, emit) => emit(
        AuthenticatedState(userModel: event.userModel),
      ),
    );

    on<LogoutEvent>((event, emit) async {
      await logoutUsecase();
      emit(UnAuthenticatedState());
    });
  }

  final AuthUserUsecase authUserUsecase;
  final SignUpUsecase signUpUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;

  StreamSubscription? streamSubscription;

  Future<void> authenticationCheck() async {
    await Future.delayed(const Duration(seconds: 1));
    streamSubscription = authUserUsecase().asStream().listen((user) {
      user.fold(
        (l) => add(UnAuthenticatedEvent()),
        (result) => add(
          AuthenticatedEvent(
            userModel: UserModel.fromEntity(result!),
          ),
        ),
      );
    });
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
