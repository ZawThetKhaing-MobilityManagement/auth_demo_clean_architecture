import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:flutter/material.dart';

class ProfileDataListTile extends StatelessWidget {
  final String title;
  final String content;
  const ProfileDataListTile({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyleData.medium,
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              content,
              style: TextStyleData.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
