import 'package:demo_login_ui/core/routes/route.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/auth_bloc.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App bar"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(
              onPressed: () {
                try {
                  context.read<AuthBloc>().add(LogoutEvent());
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(Routes.login, (route) => false);
                } catch (e) {}
              },
              widgets: const [
                Text(
                  "Logout",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.logout),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
