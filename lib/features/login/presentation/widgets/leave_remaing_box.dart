import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:flutter/material.dart';

class LeaveRemainingBox extends StatelessWidget {
  final String status;
  final Color color;
  final int remainDays;
  const LeaveRemainingBox({
    super.key,
    required this.status,
    required this.color,
    required this.remainDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 163,
      height: 84,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color,
        ),
        color: color.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status,
            style: TextStyleData.semiBold.copyWith(
              color: Colors.black,
            ),
          ),
          Text(
            "$remainDays",
            style: TextStyleData.semiBold.copyWith(
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
