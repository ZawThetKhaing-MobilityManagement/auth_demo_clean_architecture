import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(
      color: Color.fromRGBO(0, 0, 0, 0.5),
      fontSize: 14,
    ),
    filled: true,
    fillColor: const Color.fromRGBO(196, 196, 196, 0.2),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(5),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(5),
    ),
    suffixIconColor: const Color.fromRGBO(0, 0, 0, 0.2),
  ),
  useMaterial3: true,
);
