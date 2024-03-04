import 'package:flutter/material.dart';

class LoginOrRegister extends StatelessWidget {
  final String text;
  final String funText;
  final Function() onTap;
  const LoginOrRegister({
    super.key,
    required this.text,
    required this.funText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 13),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              funText,
              style: const TextStyle(
                fontSize: 13,
                color: Color.fromRGBO(255, 57, 81, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
