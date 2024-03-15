import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/routes/route.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/auth_bloc.dart';
import 'package:demo_login_ui/features/others/widgets/button.dart';
import 'package:demo_login_ui/features/others/widgets/profile_view_list_tile.dart';
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsiIcLC98l0IVWtUGXYytr99Gl3beClROnGPwrdY-1TQ&s',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        userModel.name,
                        style: TextStyleData.semiBold.copyWith(fontSize: 20),
                      ),
                      Text(
                        'Sale promoter',
                        style: TextStyleData.medium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Profile'),
                const SizedBox(height: 8),
                ProfileListTile(
                  icon: Icons.person_outline_outlined,
                  title: "My Profile",
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.myProfile);
                  },
                ),
                ProfileListTile(
                  icon: PhosphorIconsRegular.gear,
                  title: "Settings",
                  onTap: () {},
                ),
                const SizedBox(height: 8),
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
                text: 'Logout',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
