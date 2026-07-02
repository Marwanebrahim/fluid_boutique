import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyWishlistWidget extends StatelessWidget {
  const EmptyWishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 72.w,
            color: AppColors.dotsColor,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Saved Gems Yet',
            style: AppTextStyles.bold(size: 18, color: AppColors.darkBlueIcon),
          ),
          SizedBox(height: 8.h),
          Text(
            'Items you wishlist will appear here.',
            style: AppTextStyles.regular(
              size: 14,
              color: AppColors.textSecondary,
              font: AppFont.inter,
            ),
          ),
        ],
      ),
    );
  }
}
