import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.item});
  final CartEntity item;
  @override
  Widget build(BuildContext context) {
    final discounted = item.price * (1 - item.discountPercentage / 100);
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              item.thumbnail,
              width: 64.w,
              height: 64.h,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 64.w,
                height: 64.h,
                color: AppColors.dotsColor,
                child: Icon(
                  Icons.image_not_supported,
                  color: AppColors.textTertiary,
                  size: 20.w,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.semibold(
                    size: 13,
                    color: AppColors.darkBlueIcon,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Color: ${item.color}\nSize: ${item.size}',
                  style: AppTextStyles.regular(
                    size: 11,
                    color: AppColors.textTertiary,
                    font: AppFont.inter,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '\$${(discounted * item.quantity).toStringAsFixed(2)}',
                  style: AppTextStyles.bold(
                    size: 14,
                    color: AppColors.darkBlueIcon,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
