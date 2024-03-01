import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.widgets,
  });
  final void Function() onPressed;
  final List<Widget> widgets;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            const Color.fromRGBO(255, 57, 81, 1),
          ),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          alignment: Alignment.center,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        ),
      ),
    );
  }
}