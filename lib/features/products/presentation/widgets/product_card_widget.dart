// features/products/presentation/widgets/product_card_widget.dart
import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onTap;

  const ProductCardWidget({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + Badge + Wishlist
            Stack(
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product.thumbnail,
                    height: 200,
                    width: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      height: 200,
                      width: 160,
                      color: AppColors.white.withValues(alpha: 0.1),
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                // Badge (NEW TREND / ON SALE / etc.)
                if (product.tags.isNotEmpty)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        product.tags.first.toUpperCase(),
                        style: AppTextStyles.semibold(
                          size: 9,
                          color: AppColors.white,
                          font: AppFont.inter,
                        ),
                      ),
                    ),
                  ),
                // Wishlist Button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        // TODO: Add to wishlist
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 16,
                        color: AppColors.darkBlueIcon,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Brand / Collection
            if (product.brand != null)
              Text(
                product.brand!,
                style: AppTextStyles.regular(
                  size: 11,
                  color: AppColors.textSecondary,
                  font: AppFont.inter,
                ),
              ),
            const SizedBox(height: 2),
            // Product Title
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.semibold(
                size: 13,
                color: AppColors.darkBlueIcon,
              ),
            ),
            const SizedBox(height: 4),
            // Price
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: AppTextStyles.bold(
                size: 14,
                color: AppColors.darkBlueIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
