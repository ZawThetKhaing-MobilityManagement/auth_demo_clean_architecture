import 'package:demo_login_ui/features/attendence/presentation/bloc/location_bloc.dart';
import 'package:demo_login_ui/features/attendence/presentation/cubit/attendence_list_cubit/attendence_list_cubit.dart';
import 'package:demo_login_ui/features/attendence/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:demo_login_ui/features/attendence/presentation/cubit/region_list/region_list_cubit.dart';
import 'package:demo_login_ui/features/leave/presentation/bloc/leave_request_cubit.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/others/pages/change_password_page.dart';
import 'package:demo_login_ui/features/others/pages/change_profile_page.dart';
import 'package:demo_login_ui/features/others/pages/home_page.dart';
import 'package:demo_login_ui/features/others/pages/login_page.dart';
import 'package:demo_login_ui/features/others/pages/material_page.dart';
import 'package:demo_login_ui/features/others/pages/my_profile_page.dart';
import 'package:demo_login_ui/features/others/pages/setting_page.dart';
import 'package:demo_login_ui/features/others/pages/wrapper_page.dart';
import 'package:demo_login_ui/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Routes {
  static const String home = '/home';
  static const String signUp = '/signUp';
  static const String login = '/login';
  static const String wrapper = '/wrapper';
  static const String myProfile = '/myProfile';
  static const String setting = '/setting';
  static const String changePassword = '/changePassword';
  static const String changeProfile = '/changeProfile';

  static Route<dynamic>? routes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<LocationBloc>()),
              BlocProvider(
                create: (context) => sl<RegionListCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<HomeViewCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<LeaveRequestCubit>()
                  ..getLeaveList((settings.arguments as UserModel).token),
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
      case myProfile:
        return MaterialPageRoute(
          builder: (_) => MyProfilePage(
            userModel: settings.arguments as UserModel,
          ),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );

      case setting:
        return MaterialPageRoute(
          builder: (_) => const SettingPage(),
        );

      case changePassword:
        return MaterialPageRoute(
          builder: (_) => const ChangePasswordPage(),
        );
      case changeProfile:
        return MaterialPageRoute(
          builder: (_) => const ChangeProfilePage(),
        );
      default:
        MaterialPageRoute(
          builder: (_) => const MaterialScreen(),
        );
    }
    return null;
  }
}
