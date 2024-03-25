import 'package:flutter/material.dart';
import 'package:demo_login_ui/core/utils/string_ext.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String? value)? validator;

  final String hintText;
  final void Function()? onEditingComplete;

  const PasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.focusNode,
    this.validator,
    this.onEditingComplete,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;
  void isObsecure() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: obscureText,
        validator: widget.validator ??
            (_) => _?.isEmpty == true
                ? "Required"
                : _?.isValidPassword == true
                    ? null
                    : "Password required at least 8 characters",
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.hintText,
          suffixIcon: obscureText
              ? IconButton(
                  splashRadius: 10,
                  onPressed: isObsecure,
                  icon: const Icon(Icons.visibility_off),
                )
              : IconButton(
                  splashRadius: 10,
                  onPressed: isObsecure,
                  icon: const Icon(Icons.visibility),
                ),
        ),
        onEditingComplete: widget.onEditingComplete,
      ),
    );
  }
}
