import 'package:demo_login_ui/core/style/text_style.dart';
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
      height: 80,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            child: Icon(Icons.person),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userModel.name,
                style: TextStyleData.semiBold,
              ),
              Text(
                "Sale Promoter",
                style: TextStyleData.medium,
              ),
            ],
          )
        ],
      ),
    );
  }
}
