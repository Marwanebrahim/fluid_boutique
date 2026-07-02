import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool isDanger;
  final Widget? trailing;
  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.isDanger = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDanger
        ? AppColors.sale
        : (iconColor ?? AppColors.darkBlueIcon);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20.w, color: color),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.semibold(size: 14, color: color),
              ),
            ),
            SizedBox(width: 4.w),
            ?trailing,
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.w,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
