import 'dart:async';

import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/domain/usecases/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/auth_user_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/signup_usecase.dart';
import 'package:equatable/equatable.dart';

part 'authbloc_event.dart';
part 'authbloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.authUserUsecase,
    required this.signUpUsecase,
    required this.logoutUsecase,
  }) : super(AuthblocInitial()) {
    on<SignInEvent>(
      (event, emit) async {
        emit(ProcessingState());
        try {
          final result = await signUpUsecase(event.params);

          result.fold(
            (l) => emit(FaliureState()),
            (r) => emit(
              SuccessfulState(),
            ),
          );
        } catch (e) {
          emit(FaliureState());
        }
      },
    );

    on<UnAuthenticatedEvent>((event, emit) => emit(UnAuthenticatedState()));

    on<AuthenticatedEvent>(
      (event, emit) => emit(
        AuthenticatedState(userModel: event.userModel),
      ),
    );

    on<LogoutEvent>((event, emit) {
      emit(LogoutState());
      logoutUsecase();
    });

    authenticationCheck();
  }

  final AuthUserUsecase authUserUsecase;
  final SignUpUsecase signUpUsecase;
  final LogoutUsecase logoutUsecase;
  StreamSubscription? streamSubscription;

  void authenticationCheck() {
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
