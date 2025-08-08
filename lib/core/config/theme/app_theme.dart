import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yolla/core/config/constants/app_colors.dart';
import 'package:yolla/core/config/theme/input_decoration_theme.dart';
import 'package:yolla/core/config/theme/text_theme.dart';
import 'elevated_button_theme.dart';

class AppTheme {
  static final themeYolla = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      iconTheme: IconThemeData(color: AppColors.blackColor),
    ),
    brightness: Brightness.light,
    textTheme: GoogleFonts.poppinsTextTheme(AppTextTheme.lightTextTheme),
    inputDecorationTheme: YollaInputDecorationTheme.inputDecorationTheme,
    elevatedButtonTheme: YollaElevatedButtonTheme.elevatedButtonThemeData,
    dividerColor: AppColors.primaryColor,
    dividerTheme: const DividerThemeData(
      color: AppColors.lightGrayColor,
      thickness: 1,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
  );
}
