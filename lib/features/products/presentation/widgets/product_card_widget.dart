import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:fluid_boutique/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    child: BlocBuilder<WishlistBloc, WishlistState>(
                      buildWhen: (previous, current) =>
                          current is WishlistSuccessState,
                      builder: (context, state) {
                        final isWishlisted = state is WishlistSuccessState
                            ? state.wishlist.any(
                                (item) => item.id == product.id,
                              )
                            : false;
                        return IconButton(
                          onPressed: () {
                            if (isWishlisted) {
                              context.read<WishlistBloc>().add(
                                RemoveFromWishlistEvent(productID: product.id),
                              );
                            } else {
                              context.read<WishlistBloc>().add(
                                AddToWishlistEvent(
                                  product: WishlistEntity(
                                    id: product.id,
                                    title: product.title,
                                    price: product.price,
                                    discountPercentage:
                                        product.discountPercentage,
                                    availabilityStatus:
                                        product.availabilityStatus,
                                    thumbnail: product.thumbnail,
                                  ),
                                ),
                              );
                            }
                          },
                          icon: Icon(
                            isWishlisted
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isWishlisted
                                ? AppColors.sale
                                : AppColors.darkBlueIcon,
                            size: 16,
                          ),
                        );
                      },
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
