import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final PhosphorIconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        child: Row(
          children: [
            PhosphorIcon(
              icon,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyleData.semiBold.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
