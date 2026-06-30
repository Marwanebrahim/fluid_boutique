import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/orders/domain/entity/order_entity.dart';
import 'package:fluid_boutique/features/orders/presentation/widgets/order_item_row.dart';
import 'package:fluid_boutique/features/orders/presentation/widgets/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActiveOrderCard extends StatelessWidget {
  final OrderEntity order;
  const ActiveOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final stepIndex = OrderStatusHelper.getStepIndex(order.status);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'ACTIVE ORDER',
                  style: AppTextStyles.bold(
                    size: 10,
                    color: AppColors.primary,
                    font: AppFont.inter,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: OrderStatusHelper.getColor(
                    order.status,
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  OrderStatusHelper.getLabel(order.status).toUpperCase(),
                  style: AppTextStyles.bold(
                    size: 10,
                    color: OrderStatusHelper.getColor(order.status),
                    font: AppFont.inter,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Order ID
          Text(
            '#${order.id.substring(0, 8).toUpperCase()}-X',
            style: AppTextStyles.bold(size: 18, color: AppColors.darkBlueIcon),
          ),
          const SizedBox(height: 4),
          Text(
            'Placed on ${DateFormat('MMMM dd, yyyy').format(order.createdAt)}',
            style: AppTextStyles.regular(
              size: 12,
              color: AppColors.textTertiary,
              font: AppFont.inter,
            ),
          ),

          const SizedBox(height: 20),

          // Progress Tracker
          Row(
            children: List.generate(OrderStatusHelper.steps.length, (index) {
              final isCompleted = index <= stepIndex;
              final isLast = index == OrderStatusHelper.steps.length - 1;

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          // Icon
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? AppColors.primary
                                  : AppColors.dotsColor.withValues(alpha: 0.4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              OrderStatusHelper.stepIcons[index],
                              size: 16,
                              color: isCompleted
                                  ? AppColors.white
                                  : AppColors.textTertiary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          // Label
                          Text(
                            OrderStatusHelper.steps[index],
                            style: AppTextStyles.semibold(
                              size: 9,
                              color: isCompleted
                                  ? AppColors.primary
                                  : AppColors.textTertiary,
                              font: AppFont.inter,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    // Connector Line
                    if (!isLast)
                      Expanded(
                        child: Container(
                          height: 2,
                          margin: const EdgeInsets.only(bottom: 22),
                          color: index < stepIndex
                              ? AppColors.primary
                              : AppColors.dotsColor.withValues(alpha: 0.4),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),

          const SizedBox(height: 20),
          Container(height: 1, color: AppColors.dotsColor),
          const SizedBox(height: 16),

          // Package Details
          Text(
            'Package Details',
            style: AppTextStyles.bold(size: 14, color: AppColors.darkBlueIcon),
          ),
          const SizedBox(height: 12),

          ...order.items.map((item) => OrderItemRow(item: item)),

          const SizedBox(height: 16),
          Container(height: 1, color: AppColors.dotsColor),
          const SizedBox(height: 16),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppTextStyles.semibold(
                  size: 14,
                  color: AppColors.darkBlueIcon,
                ),
              ),
              Text(
                '\$${order.total.toStringAsFixed(2)}',
                style: AppTextStyles.bold(
                  size: 18,
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
