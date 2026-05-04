import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData get appTheme => ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.background,
    elevation: 0,
    alignment: Alignment.center,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    
  ),
);
