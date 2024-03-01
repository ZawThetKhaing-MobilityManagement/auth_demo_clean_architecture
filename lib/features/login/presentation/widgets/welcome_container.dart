import 'package:flutter/material.dart';

class WelcomeContainer extends StatelessWidget {
  final String mainText;
  final String subText;
  const WelcomeContainer({
    super.key,
    required this.mainText,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(bottom: 50),
      width: MediaQuery.of(context).size.width,
      height: 250,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assert/login_decoration.png'),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            mainText,
            style: const TextStyle(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(subText),
        ],
      ),
    );
  }
}
