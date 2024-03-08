import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MiniClockInOut extends StatelessWidget {
  final IconData icon;
  final String status;
  final DateTime? time;
  final String? minute;
  final String? hour;

  const MiniClockInOut({
    super.key,
    required this.icon,
    required this.status,
    this.time,
    this.hour,
    this.minute,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 32,
          color: Colors.white,
        ),
        Text(time == null ? '-' : DateFormat.jm().format(time!),
            style: TextStyleData.semiBold),
        Text(status, style: TextStyleData.regular),
      ],
    );
  }
}