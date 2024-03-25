import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/others/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final bool isSuccess;
  const CustomDialog({
    super.key,
    this.isSuccess = true,
    required this.title,
    required this.content,
  });

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
          decoration: const BoxDecoration(
            color: mainColor,
            shape: BoxShape.circle,
          ),
          child: PhosphorIcon(
            isSuccess == true ? PhosphorIconsRegular.checkCircle : Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        title,
        // isSuccess == true ? "Attendence Successful!" : "Attendence Failed!",
      ),
      content: Text(
        // isSuccess == true
        //     ? "Great job! Your attendance has been successfully recorded. You're all set for today."
        //     : title ??
        //         "You're not in specified range.Click me at specified area.",
        content,
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
          text: 'Done',
        )
      ],
    );
  }
}
