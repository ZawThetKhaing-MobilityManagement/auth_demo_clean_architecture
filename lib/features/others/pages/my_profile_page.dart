import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/others/widgets/profile_data_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyProfilePage extends StatelessWidget {
  final UserModel userModel;
  const MyProfilePage({
    super.key,
    required this.userModel,
  });

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
            ProfileDataListTile(
              title: 'Employee Name',
              content: userModel.name,
            ),
            ProfileDataListTile(
              title: 'Employee ID',
              content: userModel.userCode,
            ),
            ProfileDataListTile(
              title: 'Employee Role',
              content: userModel.employeeRole,
            ),
            ProfileDataListTile(
              title: 'Join Date',
              content:
                  DateFormat.yMd().format(DateTime.parse(userModel.joinDate)),
            ),
            ProfileDataListTile(
              title: 'Phone Number',
              content: userModel.phone,
            ),
            ProfileDataListTile(
              title: 'Office',
              content: userModel.shop,
            ),
            ProfileDataListTile(
              title: 'Office Time',
              content:
                  '${userModel.officeStartTime.substring(0, 5)} am to ${userModel.officeEndTime.substring(0, 5)} pm',
            ),
          ],
        ),
      ),
    );
  }
}
