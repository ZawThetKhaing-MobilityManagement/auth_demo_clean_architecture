import 'package:flutter/material.dart';

class PolicyCheck extends StatelessWidget {
  const PolicyCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          side: const BorderSide(
            color: Color.fromRGBO(203, 203, 203, 1),
            width: 1.5,
          ),
          value: false,
          onChanged: (value) {},
        ),
        RichText(
          text: const TextSpan(
            text: "By checking the box you agree to our ",
            style: TextStyle(color: Colors.black, fontSize: 10),
            children: [
              TextSpan(
                text: 'Terms ',
                style: TextStyle(
                  color: Color.fromRGBO(255, 57, 81, 1),
                ),
              ),
              TextSpan(text: "and "),
              TextSpan(
                text: 'Conditions',
                style: TextStyle(
                  color: Color.fromRGBO(255, 57, 81, 1),
                ),
              ),
              TextSpan(text: '.'),
            ],
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
