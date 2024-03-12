import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/routes/route.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/auth_bloc.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/button.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/profile_view_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileView extends StatelessWidget {
  final UserModel userModel;
  const ProfileView({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const PhosphorIcon(
              PhosphorIconsRegular.bell,
            ),
          )
        ],
      ),
      backgroundColor: backGroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    style: TextStyleData.semiBold.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Sale Promoter',
                                    style: TextStyleData.medium.copyWith(
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            child: const PhosphorIcon(
                                PhosphorIconsRegular.pencilSimpleLine),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Settings'),
                const SizedBox(height: 8),
                ProfileListTile(
                  icon: PhosphorIconsRegular.gear,
                  title: "Settings",
                  onTap: () {},
                ),
                const SizedBox(height: 24),
                const Text('Others'),
                const SizedBox(height: 8),
                ProfileListTile(
                  icon: PhosphorIconsRegular.shieldStar,
                  title: "Term and Conditions",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: PhosphorIconsRegular.phone,
                  title: "Contact Us",
                  onTap: () {},
                ),
                ProfileListTile(
                  icon: PhosphorIconsRegular.info,
                  title: "About",
                  onTap: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Button(
                onPressed: () {
                  try {
                    context.read<AuthBloc>().add(LogoutEvent());
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.login, (route) => false);
                  } catch (e) {
                    // ToDo ::
                  }
                },
                widgets: [
                  Text(
                    "Logout",
                    style: TextStyleData.semiBold.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
