import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileStateItem extends StatelessWidget {
  final String value;
  final String label;

  const ProfileStateItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.bold(size: 18, color: AppColors.darkBlueIcon),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: AppTextStyles.regular(
            size: 11,
            color: AppColors.textTertiary,
            font: AppFont.inter,
          ),
        ),
      ],
    );
  }
}
