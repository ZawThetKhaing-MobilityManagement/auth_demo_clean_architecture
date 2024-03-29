import 'package:flutter/material.dart';

abstract class TextStyleData {
  static TextStyle medium = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle semiBold = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle regular = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle large = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}
