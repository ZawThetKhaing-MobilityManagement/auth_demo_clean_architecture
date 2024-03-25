import 'package:demo_login_ui/core/routes/route.dart';
import 'package:demo_login_ui/core/theme/theme.dart';
import 'package:demo_login_ui/features/attendence/presentation/bloc/location_bloc.dart';
import 'package:demo_login_ui/features/attendence/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:demo_login_ui/features/attendence/presentation/cubit/region_list/region_list_cubit.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/auth_bloc.dart';
import 'package:demo_login_ui/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialScreen extends StatelessWidget {
  const MaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..authenticationCheck(),
        ),
      ],
      child: MaterialApp(
        // showPerformanceOverlay: true,
        onGenerateRoute: Routes.routes,
        initialRoute: Routes.wrapper,
        theme: themeData,
      ),
    );
  }
}
