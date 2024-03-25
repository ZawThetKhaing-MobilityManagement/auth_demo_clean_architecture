import 'dart:async';

import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/domain/usecases/change_password_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/login_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_login_ui/features/login/domain/usecases/auth_user_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required this.authUserUsecase,
      required this.loginUsecase,
      required this.logoutUsecase,
      required this.changePasswordUsecase})
      : super(AuthblocInitial()) {
    on<LoginEvent>(login);

    on<ChangePasswordEvent>(changePassword);

    on<AuthenticatedEvent>(
      (event, emit) => emit(
        AuthenticatedState(userModel: event.userModel!),
      ),
    );

    on<UnAuthenticatedEvent>((event, emit) => emit(UnAuthenticatedState()));

    on<LogoutEvent>((event, emit) async {
      await logoutUsecase();
      emit(UnAuthenticatedState());
    });
  }

  final AuthUserUsecase authUserUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final ChangePasswordUsecase changePasswordUsecase;

  StreamSubscription? streamSubscription;

  final bool _isObSecureText = false;

  bool get isObSecureText => _isObSecureText;

  Future<void> changePassword(AuthEvent event, Emitter<AuthState> emit) async {
    emit(ProcessingState(
      userModel: state.userModel,
    ));

    try {
      final result = await changePasswordUsecase(
          event.changePasswordParams!.copyWith(token: state.userModel?.token));

      result.fold(
        (l) =>
            emit(FaliureState(message: l.messages, userModel: state.userModel)),
        (r) => emit(
          PasswordChangedState(
            message: "Click done to stay logging in.",
            userModel: state.userModel,
          ),
        ),
      );
    } catch (e) {
      emit(FaliureState(
          message: 'Something Went Wrong', userModel: state.userModel));
    }
  }

  Future<void> login(AuthEvent event, Emitter emit) async {
    emit(const ProcessingState());

    try {
      final result = await loginUsecase(event.loginInParams!);

      result.fold(
        (l) => emit(FaliureState(message: l.messages)),
        (r) => emit(
          AuthenticatedState(userModel: UserModel.fromEntity(r)),
        ),
      );
    } catch (e) {
      emit(const FaliureState(message: 'Something Went Wrong'));
    }
  }

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
