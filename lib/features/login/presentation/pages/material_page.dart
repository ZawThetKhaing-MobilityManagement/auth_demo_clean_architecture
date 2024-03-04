import 'package:demo_login_ui/core/routes/route.dart';
import 'package:demo_login_ui/core/theme/theme.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/auth_bloc.dart';
import 'package:demo_login_ui/features/login/presentation/pages/home_page.dart';
import 'package:demo_login_ui/features/login/presentation/pages/login_page.dart';
import 'package:demo_login_ui/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialScreen extends StatelessWidget {
  const MaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: MaterialApp(
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            print(state);
            return Navigator(
              onGenerateRoute: Routes.routes,
              onGenerateInitialRoutes: (navigator, initialRoute) => [
                if (state is AuthenticatedState) ...[
                  MaterialPageRoute(
                    builder: (_) => HomePage(
                      userModel: state.userModel,
                    ),
                  ),
                ],
                MaterialPageRoute(builder: (_) => const LoginPage()),
              ],
              pages: [
                if (state is UnAuthenticatedState)
                  const MaterialPage(child: LoginPage()),
                if (state is AuthenticatedState) ...[
                  MaterialPage(
                    child: HomePage(
                      userModel: state.userModel,
                    ),
                  ),
                ] else ...[
                  const MaterialPage(child: LoginPage()),
                ],
              ],
              onPopPage: (route, result) => route.didPop(result),
            );
          },
        ),
        theme: themeData,
      ),
    );
  }
}
