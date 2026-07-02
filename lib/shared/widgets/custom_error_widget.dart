import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });
  final String message;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.red),
          SizedBox(height: 16.h),
          Text(
            message,
            style: AppTextStyles.semibold(
              size: 14,
              color: AppColors.darkBlueIcon,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: onRetry,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                'Try Again',
                style: AppTextStyles.semibold(size: 14, color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
