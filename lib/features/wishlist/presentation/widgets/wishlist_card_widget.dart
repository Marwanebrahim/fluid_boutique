// wishlist_card_widget.dart
import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCardWidget extends StatelessWidget {
  const WishlistCardWidget({
    super.key,
    required this.product,
    required this.onTap,
  });
  final WishlistEntity product;
  final VoidCallback onTap;

  String get _badge {
    final status = product.availabilityStatus.toLowerCase();
    if (status == 'in stock') return 'IN STOCK';
    if (status == 'low stock') return 'LOW STOCK';
    return product.availabilityStatus.toUpperCase();
  }

  Color get _badgeColor {
    final status = product.availabilityStatus.toLowerCase();
    if (status == 'in stock') return AppColors.primary;
    if (status == 'low stock') return AppColors.gold;
    return AppColors.sale;
  }

  @override
  Widget build(BuildContext context) {
    final discountedPrice =
        product.price * (1 - product.discountPercentage / 100);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + Wishlist Button
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product.thumbnail,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      color: AppColors.dotsColor.withValues(alpha: 0.3),
                      child: const Icon(
                        Icons.image_not_supported,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
                // Remove from Wishlist
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => context.read<WishlistBloc>().add(
                      RemoveFromWishlistEvent(productID: product.id),
                    ),
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.92),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        size: 16,
                        color: AppColors.sale,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Title
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.semibold(
              size: 13,
              color: AppColors.darkBlueIcon,
            ),
          ),
          const SizedBox(height: 4),
          // Price + Badge
          Row(
            children: [
              Text(
                '\$${discountedPrice.toStringAsFixed(2)}',
                style: AppTextStyles.bold(
                  size: 13,
                  color: AppColors.darkBlueIcon,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                _badge,
                style: AppTextStyles.bold(
                  size: 10,
                  color: _badgeColor,
                  font: AppFont.inter,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
