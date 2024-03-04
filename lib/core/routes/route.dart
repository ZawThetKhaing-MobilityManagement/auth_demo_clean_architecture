import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/pages/home_page.dart';
import 'package:demo_login_ui/features/login/presentation/pages/login_page.dart';
import 'package:demo_login_ui/features/login/presentation/pages/material_page.dart';
import 'package:demo_login_ui/features/login/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static const String home = '/home';
  static const String signUp = '/signUp';
  static const String login = '/login';

  static Route<dynamic>? routes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomePage(
            userModel: settings.arguments as UserModel,
          ),
        );

      case signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      default:
        MaterialPageRoute(
          builder: (_) => const MaterialScreen(),
        );
    }
    return null;
  }
}
