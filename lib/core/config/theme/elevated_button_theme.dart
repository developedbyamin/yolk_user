import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class YollaElevatedButtonTheme {
  static ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: AppColors.whiteColor,
      )
    ),
  );
}
