import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.step,
    this.action,
  });
  final String title;
  final int step;
  final String? action;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: AppTextStyles.bold(size: 13, color: AppColors.white),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.bold(size: 15, color: AppColors.darkBlueIcon),
          ),
        ),
        if (action != null)
          Text(
            action!,
            style: AppTextStyles.semibold(
              size: 13,
              color: AppColors.primary,
              font: AppFont.inter,
            ),
          ),
      ],
    );
  }
}
