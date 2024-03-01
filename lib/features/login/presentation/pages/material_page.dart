import 'package:demo_login_ui/core/theme/theme.dart';
import 'package:demo_login_ui/features/login/data/repository/authentication_repository_impl.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/authbloc_bloc.dart';
import 'package:demo_login_ui/features/login/presentation/pages/home_page.dart';
import 'package:demo_login_ui/features/login/presentation/pages/sign_up_page.dart';
import 'package:demo_login_ui/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialScreen extends StatelessWidget {
  const MaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authUserUsecase: sl(),
        signUpUsecase: sl(),
        logoutUsecase: sl(),
      ),
      child: RepositoryProvider<AuthenticationRepositoryImpl>(
        create: (context) => AuthenticationRepositoryImpl(
          userLocalDataSoure: sl(),
          userRemoteDataSource: sl(),
        ),
        child: MaterialApp(
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Navigator(
                onGenerateInitialRoutes: (navigator, initialRoute) => [
                  MaterialPageRoute(builder: (_) => const SignUpPage()),
                  if (state is AuthenticatedState) ...[
                    MaterialPageRoute(
                        builder: (_) => HomeScreen(
                              userModel: state.userModel,
                            )),
                  ]
                ],
                pages: [
                  if (state is UnAuthenticatedState)
                    const MaterialPage(child: SignUpPage()),
                  if (state is LogoutState)
                    const MaterialPage(child: SignUpPage()),
                  if (state is AuthenticatedState) ...[
                    MaterialPage(
                      child: HomeScreen(
                        userModel: state.userModel,
                      ),
                    ),
                  ] else ...[
                    const MaterialPage(child: SignUpPage()),
                  ],
                ],
                onPopPage: (route, result) => route.didPop(result),
              );
            },
          ),
          theme: themeData,
        ),
      ),
    );
  }
}
