import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final UserModel userModel;
  const HomeAppBar({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      height: 100,
      child: Image.asset('assert/app_logo.png'),
    );
  }
}
