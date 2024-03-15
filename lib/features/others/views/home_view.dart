import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/clock_in.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/home_app_bar.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/your_activity.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeView extends StatelessWidget {
  final UserModel userModel;
  const HomeView({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: HomeAppBar(
          userModel: userModel,
        ),
        actions: const [
          PhosphorIcon(
            PhosphorIconsRegular.bell,
            size: 24,
          ),
          SizedBox(width: 20),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClockIn(userModel: userModel),
          const YourActivity(),
        ],
      ),
    );
  }
}
