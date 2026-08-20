import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/orders/domain/entity/order_entity.dart';
import 'package:fluid_boutique/features/orders/presentation/widgets/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class RecentOrderCard extends StatelessWidget {
  final OrderEntity order;
  const RecentOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ID + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#ORD-${order.id.substring(0, 4).toUpperCase()}',
                style: AppTextStyles.bold(
                  size: 14,
                  color: AppColors.darkBlueIcon,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: OrderStatusHelper.getColor(
                    order.status,
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  OrderStatusHelper.getLabel(order.status),
                  style: AppTextStyles.bold(
                    size: 10,
                    color: OrderStatusHelper.getColor(order.status),
                    font: AppFont.inter,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          // Date + Items count
          Text(
            '${DateFormat('MMMM dd, yyyy').format(order.createdAt)}  •  ${order.items.length} ${order.items.length == 1 ? 'item' : 'items'}',
            style: AppTextStyles.regular(
              size: 12,
              color: AppColors.textTertiary,
              font: AppFont.inter,
            ),
          ),

          SizedBox(height: 12.h),
          Container(height: 1.h, color: AppColors.dotsColor),
          SizedBox(height: 12.h),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTextStyles.regular(
                  size: 13,
                  color: AppColors.textSecondary,
                  font: AppFont.inter,
                ),
              ),
              Text(
                '\$${order.total.toStringAsFixed(2)}',
                style: AppTextStyles.bold(
                  size: 15,
                  color: AppColors.darkBlueIcon,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
