import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/features/others/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LeaveRequestDialog extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const LeaveRequestDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: PhosphorIcon(
        icon,
        color: mainColor,
        size: 50,
      ),
      title: Text(title),
      content: Text(content),
      actions: [
        Button(
          onPressed: Navigator.of(context).pop,
          text: 'Ok',
        ),
      ],
    );
  }
}
