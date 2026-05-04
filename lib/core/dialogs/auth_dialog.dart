import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';

void showAuthDialog({required BuildContext context, required String message}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        message,
        style: AppTextStyles.semibold(size: 16, color: AppColors.darkBlueIcon),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "OK",
            style: TextStyle(color: AppColors.darkBlueIcon),
          ),
        ),
      ],
    ),
  );
}
