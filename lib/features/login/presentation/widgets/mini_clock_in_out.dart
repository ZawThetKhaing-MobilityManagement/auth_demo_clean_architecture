import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MiniClockInOut extends StatelessWidget {
  final IconData icon;
  final String status;
  final DateTime? time;

  const MiniClockInOut({
    super.key,
    required this.icon,
    required this.status,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 32,
          color:mainColor,
        ),
        Text(time == null ? '-' : DateFormat.jm().format(time!),
            style: TextStyleData.semiBold),
        Text(status, style: TextStyleData.regular,),
      ],
    );
  }
}
