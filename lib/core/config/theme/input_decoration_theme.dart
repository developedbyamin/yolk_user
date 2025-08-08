import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yolla/core/config/constants/app_colors.dart';

class YollaInputDecorationTheme {
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    labelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.mediumLightGradyColor
    ),
    floatingLabelStyle: TextStyle(
      color: AppColors.grayColor,
      fontFamily: GoogleFonts.inter().fontFamily,
    ),
    filled: true,
    fillColor: AppColors.whiteColor,
    contentPadding: const EdgeInsets.all(12),
    prefixStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.blackColor
    ),
    hintStyle: const TextStyle(
      color: AppColors.grayColor,
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.blackColor, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.lightGrayColor, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.blackColor, width: 1),
    ),
  );
}
