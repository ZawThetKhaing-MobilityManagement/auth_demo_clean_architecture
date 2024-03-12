import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/features/get_location/presentation/cubit/home_view_cubit_cubit.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/views/home_view.dart';
import 'package:demo_login_ui/features/login/presentation/views/leave_view.dart';
import 'package:demo_login_ui/features/login/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatelessWidget {
  final UserModel userModel;
  const HomePage({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    final homeViewCubit = context.read<HomeViewCubit>();
    final List<Widget> views = [
      HomeView(userModel: userModel),
      LeaveView(userModel: userModel),
      ProfileView(
        userModel: userModel,
      ),
    ];
    return Scaffold(
      body: BlocBuilder<HomeViewCubit, int>(
        builder: (_, state) => views[state],
      ),
      bottomNavigationBar: BlocBuilder<HomeViewCubit, int>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state,
            onTap: homeViewCubit.switchView,
            selectedItemColor: mainColor,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  PhosphorIconsFill.house,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: PhosphorIcon(PhosphorIconsRegular.calendar),
                label: "Leaves",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              )
            ],
          );
        },
      ),
    );
  }
}
