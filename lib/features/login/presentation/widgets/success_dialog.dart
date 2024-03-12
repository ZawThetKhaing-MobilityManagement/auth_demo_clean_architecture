import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Container(
        width: 90,
        height: 90,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: mainColor.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: mainColor,
            shape: BoxShape.circle,
          ),
          child: const PhosphorIcon(
            PhosphorIconsRegular.checkCircle,
            color: Colors.white,
          ),
        ),
      ),
      title: const Text("Attendance Successful!"),
      content: const Text(
        "Great job! Your attendance has been successfully recorded. You're all set for today.",
        textAlign: TextAlign.center,
      ),
      contentTextStyle: TextStyleData.medium.copyWith(
        color: Colors.black,
      ),
      actions: [
        Button(
          onPressed: () {
            Navigator.of(context).pop();
          },
          widgets: const [
            Text("Done"),
          ],
        )
      ],
    );
  }
}
