import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.item});
  final CartEntity item;
  @override
  Widget build(BuildContext context) {
    final discounted = item.price * (1 - item.discountPercentage / 100);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.thumbnail,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 64,
                height: 64,
                color: AppColors.dotsColor,
                child: const Icon(
                  Icons.image_not_supported,
                  color: AppColors.textTertiary,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
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
                const SizedBox(height: 4),
                Text(
                  'Color: ${item.color}\nSize: ${item.size}',
                  style: AppTextStyles.regular(
                    size: 11,
                    color: AppColors.textTertiary,
                    font: AppFont.inter,
                  ),
                ),
                const SizedBox(height: 6),
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
