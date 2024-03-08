import 'package:demo_login_ui/core/routes/route.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            print(state.userModel.token);
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home,
              (route) => false,
              arguments: state.userModel,
            );
          }
          if (state is UnAuthenticatedState) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.login,
              (route) => false,
            );
          }
        },
        child: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
