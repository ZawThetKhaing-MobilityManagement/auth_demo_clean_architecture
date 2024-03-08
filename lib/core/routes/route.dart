import 'package:demo_login_ui/features/get_location/presentation/bloc/location_bloc.dart';
import 'package:demo_login_ui/features/get_location/presentation/cubit/attendence_list_cubit/attendence_list_cubit.dart';
import 'package:demo_login_ui/features/get_location/presentation/cubit/home_view_cubit_cubit.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/pages/home_page.dart';
import 'package:demo_login_ui/features/login/presentation/pages/login_page.dart';
import 'package:demo_login_ui/features/login/presentation/pages/material_page.dart';
import 'package:demo_login_ui/features/login/presentation/pages/sign_up_page.dart';
import 'package:demo_login_ui/features/login/presentation/pages/wrapper_page.dart';
import 'package:demo_login_ui/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Routes {
  static const String home = '/home';
  static const String signUp = '/signUp';
  static const String login = '/login';
  static const String wrapper = '/wrapper';

  static Route<dynamic>? routes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<LocationBloc>()..getLocationCache(),
              ),
              BlocProvider(
                create: (context) => sl<HomeViewCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<AttendenceListCubit>()
                  ..getAttendenceList(
                      (settings.arguments as UserModel).token ?? ''),
              ),
            ],
            child: HomePage(
              userModel: settings.arguments as UserModel,
            ),
          ),
        );
      case wrapper:
        return MaterialPageRoute(
          builder: (_) => const WrapperPage(),
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
