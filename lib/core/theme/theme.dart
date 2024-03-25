import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  primaryColor: mainColor,
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
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      textStyle: MaterialStateProperty.all(
        TextStyleData.semiBold.copyWith(color: Colors.white),
      ),
      backgroundColor: MaterialStateProperty.all(
        mainColor,
      ),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      alignment: Alignment.center,
    ),
  ),
  useMaterial3: true,
);
