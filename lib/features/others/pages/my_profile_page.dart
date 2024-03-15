
import 'package:demo_login_ui/features/others/widgets/profile_data_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Profile"),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileDataListTile(
              title: 'Employee Name',
              content: 'Zaw',
            ),
            const ProfileDataListTile(
              title: 'Employee ID',
              content: '123456',
            ),
            const ProfileDataListTile(
              title: 'Employee Role',
              content: 'Sale Promoter',
            ),
            ProfileDataListTile(
              title: 'Join Date',
              content: DateFormat.yMd().format(DateTime.now()),
            ),
            const ProfileDataListTile(
              title: 'Phone Number',
              content: '0911111111',
            ),
            const ProfileDataListTile(
              title: 'Office Time',
              content: '10:00 am to 07:00 pm',
            ),
          ],
        ),
      ),
    );
  }
}
