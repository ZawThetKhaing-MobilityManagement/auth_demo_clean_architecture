import 'package:demo_login_ui/core/routes/route.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.changePassword);
            },
            title: const Text("Change Password"),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.changeProfile);
            },
            title: const Text("Change Profile"),
            trailing: const Icon(Icons.chevron_right),
          )
        ],
      ),
    );
  }
}
