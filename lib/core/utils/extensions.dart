import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// SIZEDBOX EXTENSION
extension SizedboxExtension on int {
  SizedBox get height => SizedBox(height: h);

  SizedBox get width => SizedBox(width: w);
}

/// STRING EXTENSION
extension EmailValidator on String {
  bool isValidEmail() {
    final emailRegExp = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegExp.hasMatch(this);
  }
  bool isUzbekNumber() {
    // Uzbek phone numbers should match the pattern +998 XXX XXX XXX or +998XX XXXXXXX
    final regex = RegExp(r'^\+998\d{9}$');
    return regex.hasMatch(this);
  }
}

Color randomColor() {
  Random random = Random();
  return Color.fromARGB(
    255, // Alpha value (opacity) is set to full (255)
    random.nextInt(180), // Red value
    random.nextInt(180), // Green value
    random.nextInt(180), // Blue value
  );
}