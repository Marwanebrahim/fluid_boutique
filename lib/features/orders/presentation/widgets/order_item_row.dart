import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/orders/domain/entity/order_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItemRow extends StatelessWidget {
  final OrderItemEntity item;
  const OrderItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              item.thumbnail,
              width: 56.w,
              height: 56.w,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 56.w,
                height: 56.w,
                color: AppColors.dotsColor,
                child: Icon(
                  Icons.image_not_supported,
                  color: AppColors.textTertiary,
                  size: 18.w,
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
                SizedBox(height: 2.h),
                Text(
                  '${item.color}  •  Size ${item.size}',
                  style: AppTextStyles.regular(
                    size: 11,
                    color: AppColors.textTertiary,
                    font: AppFont.inter,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Qty: ${item.quantity}',
                  style: AppTextStyles.regular(
                    size: 11,
                    color: AppColors.textTertiary,
                    font: AppFont.inter,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${(item.price * item.quantity).toStringAsFixed(2)}',
            style: AppTextStyles.bold(size: 14, color: AppColors.darkBlueIcon),
          ),
        ],
      ),
    );
  }
}
