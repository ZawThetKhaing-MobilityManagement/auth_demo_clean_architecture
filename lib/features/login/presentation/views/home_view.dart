import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/clock_in.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/home_app_bar.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/your_activity.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final UserModel userModel;
  const HomeView({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        toolbarHeight: 80,
        foregroundColor: Colors.white,
        backgroundColor: mainColor,
        title: HomeAppBar(
          userModel: userModel,
        ),
        actions: const [
          Icon(
            Icons.notifications_none,
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
