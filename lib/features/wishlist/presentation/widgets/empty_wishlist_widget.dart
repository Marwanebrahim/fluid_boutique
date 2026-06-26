import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';

class EmptyWishlistWidget extends StatelessWidget {
  const EmptyWishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.favorite_border_rounded,
            size: 72,
            color: AppColors.dotsColor,
          ),
          const SizedBox(height: 16),
          Text(
            'No Saved Gems Yet',
            style: AppTextStyles.bold(size: 18, color: AppColors.darkBlueIcon),
          ),
          const SizedBox(height: 8),
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
