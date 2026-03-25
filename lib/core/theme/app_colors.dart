import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // prevents instantiation

  // Base color
  static const primaryColor = Color(0xFF2669F6);
  static const pageBackgroundColor = Color(0xFFF4F4F4);
  static const textGreyColor = Color(0xFF828A89);
  static const textBlackColor = Color(0xFF111111);
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF000000);
  static const redColor = Color(0xFFFF0000);
  static const yellowColor = Color(0xFFFFA705);


  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFA1F9D0), // NIA Green
      Color(0xFFACC0FB), // NIA Blue
    ],
  );
}




