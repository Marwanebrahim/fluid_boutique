import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';
import 'package:fluid_boutique/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        width: 160.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + Badge + Wishlist
            Stack(
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.network(
                    product.thumbnail,
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      height: 200.h,
                      width: double.infinity,
                      color: AppColors.white.withValues(alpha: 0.1),
                      child: Icon(Icons.image_not_supported, size: 24.w),
                    ),
                  ),
                ),
                // Badge (NEW TREND / ON SALE / etc.)
                if (product.tags.isNotEmpty)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(8.r),
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
                    height: 32.h,
                    width: 32.w,
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
                            size: 16.w,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
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
            SizedBox(height: 2.h),
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
            SizedBox(height: 4.h),
            // Price
            Expanded(
              child: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: AppTextStyles.bold(
                  size: 14,
                  color: AppColors.darkBlueIcon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
